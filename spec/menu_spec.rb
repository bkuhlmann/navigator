require "spec_helper"

describe Navigator::Menu do
  ERBHandler = ActionView::Template::Handlers::ERB.new
  let(:template) { ActionView::Template.new "<html></html>", "Example", ERBHandler, {} }
  let(:menu) { Navigator::Menu.new template }

  describe "#add" do
    it "adds a single list item" do
      menu.add "li", "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds a multile list items" do
      menu.add "li", "one"
      menu.add "li", "two"
      menu.add "li", "three"
      expect(menu.render).to eq("<ul><li>one</li><li>two</li><li>three</li></ul>")
    end

    it "adds a list item that contains an unordered list with one item" do
      menu.add "li" do
        add "ul" do
          add "li", "sub"
        end
      end
      expect(menu.render).to eq("<ul><li><ul><li>sub</li></ul></li></ul>")
    end
  end

  describe "#item" do
    it "adds an item with no item or link attributes" do
      menu.item "Dashboard", "/dashboard"
      expect(menu.render).to eq('<ul><li><a href="/dashboard">Dashboard</a></li></ul>')
    end

    it "adds an item with item attributes" do
      menu.item "Dashboard", "/dashboard", class: "active"
      expect(menu.render).to eq('<ul><li class="active"><a href="/dashboard">Dashboard</a></li></ul>')
    end

    it "adds an item with item and link attributes" do
      menu.item "Dashboard", "/dashboard", {class: "active"}, {"data-enabled" => true}
      expect(menu.render).to eq('<ul><li class="active"><a data-enabled="true" href="/dashboard">Dashboard</a></li></ul>')
    end
  end

  describe "#method_missing" do
    it "adds the ul tag" do
      menu.ul
      expect(menu.render).to eq('<ul><ul></ul></ul>')
    end

    it "adds the li tag" do
      menu.li "one"
      expect(menu.render).to eq("<ul><li>one</li></ul>")
    end

    it "adds the a tag" do
      menu.a "one", href: "http://www.example.com"
      expect(menu.render).to eq('<ul><a href="http://www.example.com">one</a></ul>')
    end

    it "adds the b tag" do
      menu.b "stylistic text"
      expect(menu.render).to eq("<ul><b>stylistic text</b></ul>")
    end

    it "adds the em tag" do
      menu.em "emphasis"
      expect(menu.render).to eq("<ul><em>emphasis</em></ul>")
    end

    it "adds the s tag" do
      menu.s "strike"
      expect(menu.render).to eq("<ul><s>strike</s></ul>")
    end

    it "adds the small tag" do
      menu.small "small"
      expect(menu.render).to eq("<ul><small>small</small></ul>")
    end

    it "adds the span tag" do
      menu.span "span"
      expect(menu.render).to eq("<ul><span>span</span></ul>")
    end

    it "adds the strong tag" do
      menu.strong "bold"
      expect(menu.render).to eq("<ul><strong>bold</strong></ul>")
    end

    it "adds the sub tag" do
      menu.sub "sub-text"
      expect(menu.render).to eq("<ul><sub>sub-text</sub></ul>")
    end

    it "adds the sup tag" do
      menu.sup "super-text"
      expect(menu.render).to eq("<ul><sup>super-text</sup></ul>")
    end

    it "raises a NoMethodError when calling a non-existent method" do
      expect{Navigator::Menu.new(template) {achoo "one"}}.to raise_error(NoMethodError)
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
      expect(menu.render).to eq('<ul class="test"></ul>')
    end
  end
end
