require "spec_helper"

describe "Navigator::ActionView::InstanceMethods" do
  before :all do
    @template = ActionView::Template.new "<html></html>", "Example", ERBHandler, {}
  end

  describe ".render_navigation" do
  	it "creates an empty menu" do
  	  render_navigation.should == "<ul></ul>"
    end

  	it "creates a menu with one item" do
  	  render_navigation do
  	    li "one"
      end.should == "<ul><li>one</li></ul>"
    end

  	it "creates a menu with one item that contains a link" do
  	  url = "http://www.example.com"
  	  render_navigation do
  	    li do
  	      a "One", href: url
	      end
      end.should == '<ul><li><a href="' + url + '">One</a></li></ul>'
    end
    
  	it "raises NameError for non-existent method" do
      expect{render_navigation(@template) {bogus_method "bogus"}}.to raise_error(NameError)
    end
  end
end
