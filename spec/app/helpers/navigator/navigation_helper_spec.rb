# frozen_string_literal: true

require "rails_helper"

RSpec.describe Navigator::NavigationHelper, type: :helper do
  let(:path) { "/dashboard" }

  before { allow(self).to receive(:current_path).and_return(path) }

  describe "#navigation" do
    it "answers default (empty) menu" do
      expect(navigation).to eq("<ul></ul>")
    end

    it "answers custom (empty) menu" do
      expect(navigation("nav")).to eq("<nav></nav>")
    end

    it "answers menu with attributes" do
      nav = navigation "nav", attributes: {"data-help" => "Main site navigation."}
      expect(nav).to eq(%(<nav data-help="Main site navigation."></nav>))
    end

    it "answers menu with an item" do
      nav = navigation { li "one" }

      expect(nav).to eq("<ul><li>one</li></ul>")
    end

    it "answers menu with a link" do
      nav = navigation { link "Example", "/example" }

      expect(nav).to eq(%(<ul><a href="/example">Example</a></ul>))
    end

    it "answers menu with an item that contains a link" do
      url = "http://www.example.com"
      nav = navigation { li { a "One", attributes: {href: url} } }

      expect(nav).to eq(%(<ul><li><a href="#{url}">One</a></li></ul>))
    end

    it "answers menu with default navigation activator" do
      nav = navigation("ul") { item "Dashboard", path }
      expect(nav).to eq(%(<ul><li class="active"><a href="#{path}">Dashboard</a></li></ul>))
    end

    it "answers menu with custom navigation activator" do
      path = "/one"
      activator = Navigator::TagActivator.new search_value: path

      nav = navigation "ul", activator: do
        item "One", path
        item "Two", "/two"
      end

      expect(nav).to eq(
        %(<ul><li class="active"><a href="#{path}">One</a></li><li><a href="/two">Two</a></li></ul>)
      )
    end

    it "raises NameError for non-existent method" do
      nav = -> { navigation { bogus_method "bogus" } }
      expect(&nav).to raise_error(NameError, /bogus_method/)
    end
  end
end
