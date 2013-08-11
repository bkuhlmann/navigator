require "spec_helper"

describe Navigator::Tag do
  before :each do
    @tag = Navigator::Tag.new "li", "Not much here.", class: "example"
  end

  describe "#initialize" do
    it "should ArgumentError when no tag is supplied" do
      expect{Navigator::Tag.new}.to raise_error(ArgumentError)
    end
  end

  describe "#html_attributes" do
    it "answers key=value pair prefixed with a space" do
      @tag.html_attributes.should == 'class="example"'
    end
  end

  describe "#prefix" do
    it "answers prefix with no attributes" do
      @tag.attributes = {}
      @tag.prefix.should == "<li>"
    end

    it "answers prefix with an attribute" do
      @tag.prefix.should == '<li class="example">'
    end

    it "answers prefix with multiple attributes" do
      @tag.attributes = {class: "tooltip", "data-enabled" => true}
      @tag.prefix.should == '<li class="tooltip" data-enabled="true">'
    end
  end

  describe "#suffix" do
    it "answers closing tag" do
      @tag.suffix.should == "</li>"
    end
  end

  describe "#render" do
    it "renders an empty tag" do
      @tag = Navigator::Tag.new "li"
      @tag.render.should == "<li></li>"
    end

    it "renders an empty tag with attributes" do
      @tag.content = nil
      @tag.render.should == '<li class="example"></li>'
    end

    it "renders a tag with attributes and content" do
      @tag.render.should == '<li class="example">Not much here.</li>'
    end
  end
end
