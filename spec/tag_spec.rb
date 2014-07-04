require "spec_helper"

describe Navigator::Tag do
  let(:tag) { Navigator::Tag.new "li", "Not much here.", class: "example" }

  describe "#initialize" do
    it "raises ArgumentError when no name is supplied" do
      expect{Navigator::Tag.new}.to raise_error(ArgumentError)
    end
  end

  describe "#html_attributes" do
    it "answers key=value pair prefixed with a space" do
      expect(tag.html_attributes).to eq('class="example"')
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

    it "answers prefix with multiple attributes" do
      tag = Navigator::Tag.new "li", nil, class: "tooltip", "data-enabled" => true
      expect(tag.prefix).to eq('<li class="tooltip" data-enabled="true">')
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
      tag = Navigator::Tag.new "li", nil, class: "example"
      expect(tag.render).to eq('<li class="example"></li>')
    end

    it "renders a tag with attributes and content" do
      expect(tag.render).to eq('<li class="example">Not much here.</li>')
    end
  end
end
