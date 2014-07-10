require "spec_helper"

describe Navigator::Menu do
  let(:erb_handler) { ActionView::Template::Handlers::ERB.new }
  let(:template) { ActionView::Template.new "<html></html>", "Example", erb_handler, {} }
  let(:menu) { Navigator::Menu.new template }

  describe "#add" do
    it "adds single item" do
      menu.add "li", "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds multiple items" do
      menu.add "li", "one"
      menu.add "li", "two"
      menu.add "li", "three"
      expect(menu.render).to eq("<ul><li>one</li><li>two</li><li>three</li></ul>")
    end

    it "adds an item that contains an unordered list with one item" do
      menu.add "li" do
        add "ul" do
          add "li", "sub"
        end
      end
      expect(menu.render).to eq("<ul><li><ul><li>sub</li></ul></li></ul>")
    end

    it "adds item using default menu tag activator" do
      path = "/home"
      activator = Navigator::TagActivator.new search_value: path

      menu = Navigator::Menu.new template, "nav", {}, activator
      menu.add "a", "Home", href: path
      menu.add "a", "About", href: "/about"

      expect(menu.render).to eq(%(<nav><a href="#{path}" class="active">Home</a><a href="/about">About</a></nav>))
    end

    it "adds item using custom item tag activator" do
      activator = Navigator::TagActivator.new search_value: "/about"

      menu = Navigator::Menu.new template, "nav", {}
      menu.add "a", "Home", href: "/home"
      menu.add "a", "About", {href: "/about"}, activator

      expect(menu.render).to eq(%(<nav><a href="/home">Home</a><a href="/about" class="active">About</a></nav>))
    end
  end

  describe "#item" do
    it "adds item with no item or link attributes" do
      menu.item "Dashboard", "/dashboard"
      expect(menu.render).to eq(%(<ul><li><a href="/dashboard">Dashboard</a></li></ul>))
    end

    it "adds item with item attributes" do
      menu.item "Dashboard", "/dashboard", class: "active"
      expect(menu.render).to eq(%(<ul><li class="active"><a href="/dashboard">Dashboard</a></li></ul>))
    end

    it "adds item with item and link attributes" do
      menu.item "Dashboard", "/dashboard", {class: "active"}, {"data-enabled" => true}
      expect(menu.render).to eq(%(<ul><li class="active"><a data-enabled="true" href="/dashboard">Dashboard</a></li></ul>))
    end

    it "adds item using default menu tag activator" do
      activator = Navigator::TagActivator.new search_value: "/users"

      menu = Navigator::Menu.new template, "ul", {}, activator
      menu.item "Dashboard", "/dashboard"
      menu.item "Users", "/users"

      expect(menu.render).to eq(%(<ul><li><a href="/dashboard">Dashboard</a></li><li class="active"><a href="/users">Users</a></li></ul>))
    end

    it "adds item using custom item tag activator" do
      activator = Navigator::TagActivator.new search_value: "/dashboard"

      menu = Navigator::Menu.new template
      menu.item "Dashboard", "/dashboard", {}, {}, activator
      menu.item "Users", "/users"

      expect(menu.render).to eq(%(<ul><li class="active"><a href="/dashboard">Dashboard</a></li><li><a href="/users">Users</a></li></ul>))
    end
  end

  describe "#respond_to?" do
    it "answers true for a valid tag" do
      expect(menu.respond_to? "section").to eq(true)
    end

    it "answers false for an invalid tag" do
      expect(menu.respond_to? "bogus").to eq(false)
    end
  end

  describe "#method_missing" do
    context "header tags" do
      it "adds a section tag" do
        menu.section "section"
        expect(menu.render).to eq("<ul><section>section</section></ul>")
      end

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

    it "adds ul tag" do
      menu.ul
      expect(menu.render).to eq("<ul><ul></ul></ul>")
    end

    it "adds li tag" do
      menu.li "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds a tag" do
      menu.a "one", href: "http://www.example.com"
      expect(menu.render).to eq(%(<ul><a href="http://www.example.com">one</a></ul>))
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

    it "raises no method error when calling non-existent method" do
      unknown_method = -> { Navigator::Menu.new(template) { achoo "one" } }
      expect(&unknown_method).to raise_error(NoMethodError)
    end
  end

  describe "#render" do
    it "renders an empty menu" do
      expect(menu.render).to eq("<ul></ul>")
    end

    it "renders with a nav tag" do
      expect(Navigator::Menu.new(template, "nav").render).to eq("<nav></nav>")
    end

    it "renders one attribute with no content" do
      menu = Navigator::Menu.new template, "ul", class: "test"
      expect(menu.render).to eq(%(<ul class="test"></ul>))
    end
  end
end
