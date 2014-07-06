require "spec_helper"

describe "Navigator::ActionView::InstanceMethods" do
  include ActionView::Helpers
  include Navigator::ActionView::InstanceMethods

  let(:erb_handler) { ActionView::Template::Handlers::ERB.new }
  let(:template) { ActionView::Template.new "<html></html>", "Example", erb_handler, {} }

  describe "#navigation" do
    it "answers default (empty) menu" do
      expect(navigation).to eq("<ul></ul>")
    end

    it "answers custom (empty) menu" do
      expect(navigation("nav")).to eq("<nav></nav>")
    end

    it "answers menu with attributes" do
      nav = navigation "nav", "data-help" => "Main site navigation."
      expect(nav).to eq(%(<nav data-help="Main site navigation."></nav>))
    end

    it "answers menu with one item" do
      nav = navigation do
        li "one"
      end

      expect(nav).to eq("<ul><li>one</li></ul>")
    end

    it "answers menu with one item that contains a link" do
      url = "http://www.example.com"
      nav = navigation do
        li do
          a "One", href: url
        end
      end

      expect(nav).to eq(%(<ul><li><a href="#{url}">One</a></li></ul>))
    end

    it "answers menu with custom tag activator" do
      url = "/dashboard"
      activator = Navigator::TagActivator.new search_value: url

      nav = navigation "ul", {}, activator do
        item "Dashboard", url
      end

      expect(nav).to eq(%(<ul><li class="active"><a href="#{url}">Dashboard</a></li></ul>))
    end

    it "raises NameError for non-existent method" do
      nav = -> { navigation(template) { bogus_method "bogus" } }
      expect(&nav).to raise_error(NameError)
    end
  end
end
