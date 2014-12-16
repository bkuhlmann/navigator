require "spec_helper"

describe Navigator::Tag do
  let(:tag) { Navigator::Tag.new "li", "Example text.", attributes: {class: "example"} }

  describe "#initialize" do
    it "raises ArgumentError when no name is supplied" do
      expect{Navigator::Tag.new}.to raise_error(ArgumentError)
    end
  end

  describe "#prefix" do
    it "answers prefix with no attributes" do
      tag = Navigator::Tag.new "li"
      expect(tag.prefix).to eq("<li>")
    end

    it "answers prefix with an attribute" do
      expect(tag.prefix).to eq('<li class="example">')
    end

    it "answers prefix with expanded data attibutes" do
      tag = Navigator::Tag.new "li", attributes: {data: {one: "one", two: "two"}}
      expect(tag.prefix).to eq('<li data-one="one" data-two="two">')
    end

    it "answers prefix with multiple attributes" do
      tag = Navigator::Tag.new "li", attributes: {class: "tooltip", "data-enabled" => true}
      expect(tag.prefix).to eq('<li class="tooltip" data-enabled="true">')
    end

    it "answers prefix with custom activator" do
      path = "/some/path"
      activator = Navigator::TagActivator.new search_value: path
      tag = Navigator::Tag.new "a", "Example", attributes: {href: path}, activator: activator

      expect(tag.prefix).to eq(%(<a href="#{path}" class="active">))
    end
  end

  describe "#suffix" do
    it "answers closing tag" do
      expect(tag.suffix).to eq("</li>")
    end
  end

  describe "#render" do
    it "renders an empty tag" do
      tag = Navigator::Tag.new "li"
      expect(tag.render).to eq("<li></li>")
    end

    it "renders an empty tag with attributes" do
      tag = Navigator::Tag.new "li", attributes: {class: "example"}
      expect(tag.render).to eq('<li class="example"></li>')
    end

    it "renders a tag with attributes and content" do
      expect(tag.render).to eq('<li class="example">Example text.</li>')
    end
  end
end
