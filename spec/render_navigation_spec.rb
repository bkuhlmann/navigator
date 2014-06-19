require "spec_helper"

describe "Navigator::ActionView::InstanceMethods" do
  include ActionView::Helpers
  include Navigator::ActionView::InstanceMethods
  ERBHandler = ActionView::Template::Handlers::ERB.new

  let(:template) { ActionView::Template.new "<html></html>", "Example", ERBHandler, {} }

  describe "#render_navigation" do
    it "creates an empty menu" do
      expect(render_navigation).to eq("<ul></ul>")
    end

    it "creates a menu with one item" do
      expect(render_navigation do
        li "one"
      end).to eq("<ul><li>one</li></ul>")
    end

    it "creates a menu with one item that contains a link" do
      url = "http://www.example.com"
      expect(render_navigation do
        li do
          a "One", href: url
        end
      end).to eq('<ul><li><a href="' + url + '">One</a></li></ul>')
    end

    it "raises NameError for non-existent method" do
      expect{render_navigation(template) {bogus_method "bogus"}}.to raise_error(NameError)
    end
  end
end
