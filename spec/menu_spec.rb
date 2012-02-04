require "spec_helper"

describe Navigator::Menu do
  before :all do
    @template = ActionView::Template.new "<html></html>", "Example", ERBHandler, {}
  end
  
  before :each do
    @menu = Navigator::Menu.new @template
  end

  describe ".initialize" do
    it "has default options" do
      @menu.options.should == {active: "active"}
    end
  end

  describe ".add" do
    it "adds a single list item" do
      @menu.add "li", "one"
      @menu.render.should == "<ul><li>one</li></ul>"
    end
    
    it "adds a multile list items" do
      @menu.add "li", "one"
      @menu.add "li", "two"
      @menu.add "li", "three"
      @menu.render.should == "<ul><li>one</li><li>two</li><li>three</li></ul>"
    end
    
    it "adds a list item that contains an unordered list with one item" do
      @menu.add "li" do
        add "ul" do
          add "li", "sub"
        end
      end
      @menu.render.should == "<ul><li><ul><li>sub</li></ul></li></ul>"
    end
  end
  
  describe ".item" do
    it "adds an item with no item or link attributes" do
      @menu.item "Dashboard", "/dashboard"
      @menu.render.should == '<ul><li><a href="/dashboard">Dashboard</a></li></ul>' 
    end
  
    it "adds an item with item attributes" do
      @menu.item "Dashboard", "/dashboard", class: "active"
      @menu.render.should == '<ul><li class="active"><a href="/dashboard">Dashboard</a></li></ul>' 
    end
  
    it "adds an item with item and link attributes" do
      @menu.item "Dashboard", "/dashboard", {class: "active"}, {"data-enabled" => true}
      @menu.render.should == '<ul><li class="active"><a href="/dashboard" data-enabled="true">Dashboard</a></li></ul>' 
    end
  end

  describe ".method_missing" do
    it "adds the ul tag" do
      @menu.ul
      @menu.render.should == '<ul><ul></ul></ul>'
    end

    it "adds the li tag" do
      @menu.li "one"
      @menu.render.should == "<ul><li>one</li></ul>"
    end

    it "adds the a tag" do
      @menu.a "one", href: "http://www.example.com"
      @menu.render.should == '<ul><a href="http://www.example.com">one</a></ul>'
    end
    
    it "adds the b tag" do
      @menu.b "stylistic text"
      @menu.render.should == "<ul><b>stylistic text</b></ul>"
    end
    
    it "adds the em tag" do
      @menu.em "emphasis"
      @menu.render.should == "<ul><em>emphasis</em></ul>"
    end
    
    it "adds the s tag" do
      @menu.s "strike"
      @menu.render.should == "<ul><s>strike</s></ul>"
    end
    
    it "adds the small tag" do
      @menu.small "small"
      @menu.render.should == "<ul><small>small</small></ul>"
    end
    
    it "adds the span tag" do
      @menu.span "span"
      @menu.render.should == "<ul><span>span</span></ul>"
    end
    
    it "adds the strong tag" do
      @menu.strong "bold"
      @menu.render.should == "<ul><strong>bold</strong></ul>"
    end
    
    it "adds the sub tag" do
      @menu.sub "sub-text"
      @menu.render.should == "<ul><sub>sub-text</sub></ul>"
    end
    
    it "adds the sup tag" do
      @menu.sup "super-text"
      @menu.render.should == "<ul><sup>super-text</sup></ul>"
    end
    
    it "raises a NoMethodError when calling a non-existent method" do
      expect{Navigator::Menu.new(@template) {achoo "one"}}.to raise_error(NoMethodError)
    end
  end
  
  describe ".render" do
    it "renders an empty menu" do
      @menu.render.should == "<ul></ul>"
    end
  
    it "renders with a nav tag" do
      Navigator::Menu.new(@template, "nav").render.should == "<nav></nav>"
    end
  
    it "renders one attribute with no content" do
      @menu = Navigator::Menu.new @template, "ul", class: "test"
      @menu.render.should == '<ul class="test"></ul>'
    end
  end
end
