# frozen_string_literal: true

require "rails_helper"

# rubocop:disable Metrics/LineLength
RSpec.describe Navigator::Menu do
  let(:erb_handler) { ActionView::Template::Handlers::ERB.new }
  let(:template) { ActionView::Template.new "<html></html>", "Example", erb_handler, {} }
  let(:menu) { Navigator::Menu.new template }

  describe "#add" do
    it "adds single tag" do
      menu.add "li", "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds single tag with multiple data attributes" do
      menu.add "li", "one", attributes: {data: {one: 1, two: 2}}
      expect(menu.render).to eq(%(<ul><li data-one="1" data-two="2">one</li></ul>))
    end

    it "adds multiple tags" do
      menu.add "li", "one"
      menu.add "li", "two"
      menu.add "li", "three"
      expect(menu.render).to eq("<ul><li>one</li><li>two</li><li>three</li></ul>")
    end

    it "adds nested tags" do
      menu.add "li" do
        add "ul" do
          add "li", "sub"
        end
      end
      expect(menu.render).to eq("<ul><li><ul><li>sub</li></ul></li></ul>")
    end

    it "adds tag with nested link" do
      menu.add "li" do
        link "One", "/one"
      end
      expect(menu.render).to eq(%(<ul><li><a href="/one">One</a></li></ul>))
    end

    it "adds tag with nested item" do
      menu.add "section" do
        item "One", "/one"
      end
      expect(menu.render).to eq(%(<ul><section><li><a href="/one">One</a></li></section></ul>))
    end

    it "adds tag using default menu tag activator" do
      path = "/home"
      activator = Navigator::TagActivator.new search_value: path

      menu = Navigator::Menu.new template, tag: "nav", activator: activator
      menu.add "a", "Home", attributes: {href: path}
      menu.add "a", "About", attributes: {href: "/about"}

      expect(menu.render).to eq(%(<nav><a href="#{path}" class="active">Home</a><a href="/about">About</a></nav>))
    end

    it "adds tag using custom item tag activator" do
      activator = Navigator::TagActivator.new search_value: "/about"

      menu = Navigator::Menu.new template, tag: "nav"
      menu.add "a", "Home", attributes: {href: "/home"}
      menu.add "a", "About", attributes: {href: "/about"}, activator: activator

      expect(menu.render).to eq(%(<nav><a href="/home">Home</a><a href="/about" class="active">About</a></nav>))
    end
  end

  describe "#link" do
    context "with attributes" do
      it "adds link" do
        menu.link "Example", "/example"
        expect(menu.render).to eq(%(<ul><a href="/example">Example</a></ul>))
      end

      it "adds link with no content" do
        menu.link "/example"
        expect(menu.render).to eq(%(<ul><a href="/example"></a></ul>))
      end

      it "adds link with attributes" do
        menu.link "Example", "/example", attributes: {class: "active"}
        expect(menu.render).to eq(%(<ul><a class="active" href="/example">Example</a></ul>))
      end
    end

    context "with activators" do
      it "adds link using menu tag activator" do
        activator = Navigator::TagActivator.new search_value: "/examples/1"

        menu = Navigator::Menu.new template, activator: activator
        menu.link "Example 1", "/examples/1"
        menu.link "Example 2", "/examples/2"

        expect(menu.render).to eq(%(<ul><a href="/examples/1" class="active">Example 1</a><a href="/examples/2">Example 2</a></ul>))
      end

      it "adds link using link tag activator" do
        activator = Navigator::TagActivator.new search_value: "/examples/2"

        menu = Navigator::Menu.new template
        menu.link "Example 1", "/examples/1"
        menu.link "Example 2", "/examples/2", activator: activator

        expect(menu.render).to eq(%(<ul><a href="/examples/1">Example 1</a><a href="/examples/2" class="active">Example 2</a></ul>))
      end

      it "adds link where link tag activator trumps menu tag activator" do
        menu_activator = Navigator::TagActivator.new search_value: "/examples/1"
        link_activator = Navigator::TagActivator.new search_value: "/examples/2"

        menu = Navigator::Menu.new template, activator: menu_activator
        menu.link "Example 1", "/examples/1"
        menu.link "Example 2", "/examples/2", activator: link_activator

        expect(menu.render).to eq(%(<ul><a href="/examples/1" class="active">Example 1</a><a href="/examples/2" class="active">Example 2</a></ul>))
      end

      context "with blocks" do
        it "renders a block" do
          menu.link("/example") { span "Test" }
          expect(menu.render).to eq(%(<ul><a href="/example"><span>Test</span></a></ul>))
        end

        it "renders content with a block" do
          menu.link("Example: ", "/example") { span "Test" }
          expect(menu.render).to eq(%(<ul><a href="/example">Example: <span>Test</span></a></ul>))
        end
      end
    end
  end

  describe "#image" do
    context "with attributes" do
      it "adds image" do
        menu.image "/example", "Example"
        expect(menu.render).to eq(%(<ul><img src="/example" alt="Example"></ul>))
      end

      it "adds image with no alt" do
        menu.image "/example"
        expect(menu.render).to eq(%(<ul><img src="/example"></ul>))
      end

      it "adds image with attributes" do
        menu.image "/example", attributes: {class: "active"}
        expect(menu.render).to eq(%(<ul><img class="active" src="/example"></ul>))
      end
    end

    context "with activators" do
      it "adds image using menu tag activator" do
        activator = Navigator::TagActivator.new search_key: "src", search_value: "/examples/1"

        menu = Navigator::Menu.new template, activator: activator
        menu.image "/examples/1"
        menu.image "/examples/2"

        expect(menu.render).to eq(%(<ul><img src="/examples/1" class="active"><img src="/examples/2"></ul>))
      end

      it "adds image using image tag activator" do
        activator = Navigator::TagActivator.new search_key: "src", search_value: "/examples/2"

        menu = Navigator::Menu.new template
        menu.image "/examples/1"
        menu.image "/examples/2", activator: activator

        expect(menu.render).to eq(%(<ul><img src="/examples/1"><img src="/examples/2" class="active"></ul>))
      end

      it "adds image where image tag activator trumps menu tag activator" do
        menu_activator = Navigator::TagActivator.new search_key: "src", search_value: "/examples/1"
        image_activator = Navigator::TagActivator.new search_key: "src", search_value: "/examples/2"

        menu = Navigator::Menu.new template, activator: menu_activator
        menu.image "/examples/1"
        menu.image "/examples/2", activator: image_activator

        expect(menu.render).to eq(%(<ul><img src="/examples/1" class="active"><img src="/examples/2" class="active"></ul>))
      end
    end

    context "with blocks" do
      it "ignores block" do
        menu.image("/example") { "Nothing to see here." }
        expect(menu.render).to eq(%(<ul><img src="/example"></ul>))
      end
    end
  end

  describe "#item" do
    context "with attributes" do
      it "adds item with no item or link attributes" do
        menu.item "Dashboard", "/dashboard"
        expect(menu.render).to eq(%(<ul><li><a href="/dashboard">Dashboard</a></li></ul>))
      end

      it "adds item with no link content" do
        menu.item "/dashboard"
        expect(menu.render).to eq(%(<ul><li><a href="/dashboard"></a></li></ul>))
      end

      it "adds item with item attributes" do
        menu.item "Dashboard", "/dashboard", item_attributes: {class: "active"}
        expect(menu.render).to eq(%(<ul><li class="active"><a href="/dashboard">Dashboard</a></li></ul>))
      end

      it "adds item with item and link attributes" do
        menu.item "Dashboard", "/dashboard", item_attributes: {class: "active"}, link_attributes: {"data-enabled" => true}
        expect(menu.render).to eq(%(<ul><li class="active"><a data-enabled="true" href="/dashboard">Dashboard</a></li></ul>))
      end

      it "adds item with multiple data attributes for item and link" do
        menu.item "Test", "/test", item_attributes: {data: {one: 1, two: 2}}, link_attributes: {data: {a: "A", b: "B"}}
        expect(menu.render).to eq(%(<ul><li data-one="1" data-two="2"><a href="/test" data-a="A" data-b="B">Test</a></li></ul>))
      end
    end

    context "with activators" do
      it "adds item using default menu tag activator" do
        activator = Navigator::TagActivator.new search_value: "/users"

        menu = Navigator::Menu.new template, activator: activator
        menu.item "Dashboard", "/dashboard"
        menu.item "Users", "/users"

        expect(menu.render).to eq(%(<ul><li><a href="/dashboard">Dashboard</a></li><li class="active"><a href="/users">Users</a></li></ul>))
      end

      it "adds item with target value appended" do
        activator = Navigator::TagActivator.new search_value: "/two"

        menu = Navigator::Menu.new template, activator: activator
        menu.item "One", "/one"
        menu.item "Two", "/two", item_attributes: {class: "test"}

        expect(menu.render).to eq(%(<ul><li><a href="/one">One</a></li><li class="test active"><a href="/two">Two</a></li></ul>))
      end

      it "adds item using custom item tag activator" do
        activator = Navigator::TagActivator.new search_value: "/dashboard"

        menu = Navigator::Menu.new template
        menu.item "Dashboard", "/dashboard", activator: activator
        menu.item "Users", "/users"

        expect(menu.render).to eq(%(<ul><li class="active"><a href="/dashboard">Dashboard</a></li><li><a href="/users">Users</a></li></ul>))
      end

      it "adds item where item activator trumps menu tag activator" do
        menu_activator = Navigator::TagActivator.new search_value: "/one"
        item_activator = Navigator::TagActivator.new search_value: "/two"

        menu = Navigator::Menu.new template, activator: menu_activator
        menu.item "One", "/one"
        menu.item "Two", "/two", activator: item_activator
        menu.item "Three", "/three"

        expect(menu.render).to eq(%(<ul><li class="active"><a href="/one">One</a></li><li class="active"><a href="/two">Two</a></li><li><a href="/three">Three</a></li></ul>))
      end
    end

    context "with blocks" do
      it "renders a block" do
        menu.item("/test") { b "X" }
        expect(menu.render).to eq(%(<ul><li><a href="/test"><b>X</b></a></li></ul>))
      end

      it "renders content with a block" do
        menu.item("Test: ", "/test") { b "X" }
        expect(menu.render).to eq(%(<ul><li><a href="/test">Test: <b>X</b></a></li></ul>))
      end
    end
  end

  describe "#respond_to?" do
    it "answers true for a valid tag" do
      expect(menu.respond_to?("section")).to eq(true)
    end

    it "answers false for an invalid tag" do
      expect(menu.respond_to?("bogus")).to eq(false)
    end
  end

  describe "#method_missing" do
    it "adds a div tag" do
      menu.div "div"
      expect(menu.render).to eq("<ul><div>div</div></ul>")
    end

    it "adds a section tag" do
      menu.section "section"
      expect(menu.render).to eq("<ul><section>section</section></ul>")
    end

    it "adds a header tag" do
      menu.header "header"
      expect(menu.render).to eq("<ul><header>header</header></ul>")
    end

    context "header tags" do
      it "adds an h1 tag" do
        menu.h1 "header"
        expect(menu.render).to eq("<ul><h1>header</h1></ul>")
      end

      it "adds an h2 tag" do
        menu.h2 "header"
        expect(menu.render).to eq("<ul><h2>header</h2></ul>")
      end

      it "adds an h3 tag" do
        menu.h3 "header"
        expect(menu.render).to eq("<ul><h3>header</h3></ul>")
      end

      it "adds an h4 tag" do
        menu.h4 "header"
        expect(menu.render).to eq("<ul><h4>header</h4></ul>")
      end

      it "adds an h5 tag" do
        menu.h5 "header"
        expect(menu.render).to eq("<ul><h5>header</h5></ul>")
      end

      it "adds an h6 tag" do
        menu.h6 "header"
        expect(menu.render).to eq("<ul><h6>header</h6></ul>")
      end

      it "raises no method error for h method" do
        unknown_method = -> { menu.h }
        expect(&unknown_method).to raise_error(NoMethodError)
      end

      it "raises no method error for h0 method" do
        unknown_method = -> { menu.h0 }
        expect(&unknown_method).to raise_error(NoMethodError)
      end

      it "raises no method error for h7 method" do
        unknown_method = -> { menu.h7 }
        expect(&unknown_method).to raise_error(NoMethodError)
      end
    end

    it "adds nav tag" do
      menu.nav
      expect(menu.render).to eq("<ul><nav></nav></ul>")
    end

    it "adds ul tag" do
      menu.ul
      expect(menu.render).to eq("<ul><ul></ul></ul>")
    end

    it "adds li tag" do
      menu.li "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds a tag" do
      menu.a "one", attributes: {href: "http://www.example.com"}
      expect(menu.render).to eq(%(<ul><a href="http://www.example.com">one</a></ul>))
    end

    it "adds img tag" do
      url = "http://placehold.it/200x50"
      menu.img attributes: {src: url}

      expect(menu.render).to eq(%(<ul><img src="#{url}"></ul>))
    end

    it "adds b tag" do
      menu.b "stylistic text"
      expect(menu.render).to eq("<ul><b>stylistic text</b></ul>")
    end

    it "adds em tag" do
      menu.em "emphasis"
      expect(menu.render).to eq("<ul><em>emphasis</em></ul>")
    end

    it "adds s tag" do
      menu.s "strike"
      expect(menu.render).to eq("<ul><s>strike</s></ul>")
    end

    it "adds small tag" do
      menu.small "small"
      expect(menu.render).to eq("<ul><small>small</small></ul>")
    end

    it "adds span tag" do
      menu.span "span"
      expect(menu.render).to eq("<ul><span>span</span></ul>")
    end

    it "adds strong tag" do
      menu.strong "bold"
      expect(menu.render).to eq("<ul><strong>bold</strong></ul>")
    end

    it "adds sub tag" do
      menu.sub "sub-text"
      expect(menu.render).to eq("<ul><sub>sub-text</sub></ul>")
    end

    it "adds sup tag" do
      menu.sup "super-text"
      expect(menu.render).to eq("<ul><sup>super-text</sup></ul>")
    end

    it "adds form tag" do
      menu.form "form"
      expect(menu.render).to eq("<ul><form>form</form></ul>")
    end

    it "adds label tag" do
      menu.label "label"
      expect(menu.render).to eq("<ul><label>label</label></ul>")
    end

    it "adds select tag" do
      menu.select
      expect(menu.render).to eq("<ul><select></select></ul>")
    end

    it "adds option tag" do
      menu.option
      expect(menu.render).to eq("<ul><option></option></ul>")
    end

    it "adds input tag" do
      menu.input "input"
      expect(menu.render).to eq("<ul><input></ul>")
    end

    it "adds button tag" do
      menu.button "button"
      expect(menu.render).to eq("<ul><button>button</button></ul>")
    end

    it "raises no method error when calling non-existent method" do
      unknown_method = -> { Navigator::Menu.new(template) { achoo content: "one" } }
      expect(&unknown_method).to raise_error(NoMethodError)
    end
  end

  describe "#render" do
    it "renders an empty menu" do
      expect(menu.render).to eq("<ul></ul>")
    end

    it "renders with a nav tag" do
      expect(Navigator::Menu.new(template, tag: "nav").render).to eq("<nav></nav>")
    end

    it "renders one attribute with no content" do
      menu = Navigator::Menu.new template, attributes: {class: "test"}
      expect(menu.render).to eq(%(<ul class="test"></ul>))
    end
  end
end
