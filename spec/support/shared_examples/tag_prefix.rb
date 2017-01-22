# frozen_string_literal: true

RSpec.shared_examples_for "a tag prefix" do |name|
  it "answers prefix with no attributes" do
    tag = Navigator::Tag.new name
    expect(tag.prefix).to eq("<#{name}>")
  end

  it "answers prefix with attribute" do
    tag = Navigator::Tag.new name, attributes: {class: "example"}
    expect(tag.prefix).to eq(%(<#{name} class="example">))
  end

  it "answers prefix with expanded data attibutes" do
    tag = Navigator::Tag.new name, attributes: {data: {one: "one", two: "two"}}
    expect(tag.prefix).to eq(%(<#{name} data-one="one" data-two="two">))
  end

  it "answers prefix with multiple attributes" do
    tag = Navigator::Tag.new name, attributes: {class: "tooltip", "data-enabled" => true}
    expect(tag.prefix).to eq(%(<#{name} class="tooltip" data-enabled="true">))
  end

  context "with activator" do
    let(:path) { "/some/path" }
    let(:activator) { Navigator::TagActivator.new search_value: path }

    it "answers prefix with target value added" do
      tag = Navigator::Tag.new name, "Example", attributes: {href: path}, activator: activator
      expect(tag.prefix).to eq(%(<#{name} href="#{path}" class="active">))
    end

    it "answers prefix with target value appended" do
      tag = Navigator::Tag.new name,
                               "Example",
                               attributes: {href: path, class: "test"},
                               activator: activator

      expect(tag.prefix).to eq(%(<#{name} href="#{path}" class="test active">))
    end
  end
end
