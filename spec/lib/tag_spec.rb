# frozen_string_literal: true

require "rails_helper"

RSpec.describe Navigator::Tag do
  let(:tag) { Navigator::Tag.new "li", "Example text.", attributes: {class: "example"} }

  describe "#initialize" do
    it "raises ArgumentError when no name is supplied" do
      result = -> { Navigator::Tag.new }
      expect(&result).to raise_error(ArgumentError)
    end
  end

  describe "#prefix" do
    it "answers prefix as string" do
      tag = Navigator::Tag.new :li
      expect(tag.prefix).to eq("<li>")
    end

    context "with suffix" do
      it_behaves_like "a tag prefix", "a"
    end

    context "without suffix" do
      described_class.names_without_suffix.each do |name|
        it_behaves_like "a tag prefix", name
      end
    end
  end

  describe "#computed_content" do
    context "with suffix" do
      it "answers content" do
        expect(tag.computed_content).to eq("Example text.")
      end
    end

    context "without suffix" do
      it "answers nil" do
        described_class.names_without_suffix.each do |name|
          tag = Navigator::Tag.new name, "Example text."
          expect(tag.computed_content).to eq(nil)
        end
      end
    end
  end

  describe "#suffix" do
    it "answers suffix as string" do
      tag = Navigator::Tag.new :li
      expect(tag.suffix).to eq("</li>")
    end

    context "with suffix" do
      it "answers suffix" do
        expect(tag.suffix).to eq("</li>")
      end
    end

    context "without suffix" do
      it "excludes suffix" do
        described_class.names_without_suffix.each do |name|
          tag = Navigator::Tag.new name
          expect(tag.suffix).to eq(nil)
        end
      end
    end
  end

  describe "#render" do
    it "renders tag as string" do
      tag = Navigator::Tag.new :li
      expect(tag.render).to eq("<li></li>")
    end

    context "with suffix" do
      it "renders empty tag" do
        tag = Navigator::Tag.new "li"
        expect(tag.render).to eq("<li></li>")
      end

      it "renders empty tag with attributes" do
        tag = Navigator::Tag.new "li", attributes: {class: "example"}
        expect(tag.render).to eq('<li class="example"></li>')
      end

      it "renders tag with attributes and content" do
        expect(tag.render).to eq('<li class="example">Example text.</li>')
      end
    end

    context "without suffix" do
      described_class.names_without_suffix.each do |name|
        it "renders prefix" do
          tag = Navigator::Tag.new name
          expect(tag.render).to eq("<#{name}>")
        end

        it "renders prefix with attributes" do
          tag = Navigator::Tag.new name, attributes: {class: "example"}
          expect(tag.render).to eq(%(<#{name} class="example">))
        end

        it "renders prefix without content" do
          tag = Navigator::Tag.new name, "Test"
          expect(tag.render).to eq("<#{name}>")
        end
      end
    end
  end
end
