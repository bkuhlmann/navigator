# frozen_string_literal: true

require "rails_helper"

RSpec.describe Navigator::TagActivator do
  subject(:activator) { described_class.new }

  describe "#search_key" do
    it "answers default key" do
      expect(activator.search_key).to eq(:href)
    end

    it "answers custom key" do
      activator = described_class.new search_key: "data-url"
      expect(activator.search_key).to eq("data-url")
    end
  end

  describe "#search_value" do
    it "answers default value" do
      expect(activator.search_value).to be_nil
    end

    it "answers custom value" do
      activator = described_class.new search_value: "custom"
      expect(activator.search_value).to eq("custom")
    end
  end

  describe "#target_key" do
    it "answers default key" do
      expect(activator.target_key).to eq(:class)
    end

    it "answers custom key" do
      activator = described_class.new target_key: "data-url"
      expect(activator.target_key).to eq("data-url")
    end
  end

  describe "#target_value" do
    it "answers default value" do
      expect(activator.target_value).to eq("active")
    end

    it "answers custom value" do
      activator = described_class.new target_value: "custom"
      expect(activator.target_value).to eq("custom")
    end
  end

  describe "activatable?" do
    subject(:activator) { described_class.new search_value: }

    let(:search_value) { "/example/path" }

    context "with search value" do
      it "answers true when search value is found" do
        result = activator.activatable? href: search_value
        expect(result).to be(true)
      end

      it "answers false when search value is not found" do
        result = activator.activatable? href: "/unknown/path"
        expect(result).to be(false)
      end
    end

    context "without search value" do
      subject(:activator) { described_class.new }

      it "answers false with attributes" do
        result = activator.activatable? href: search_value
        expect(result).to be(false)
      end

      it "answers false without attributes" do
        result = activator.activatable?
        expect(result).to be(false)
      end
    end

    context "with indifferent access" do
      it "answers true when string attribute key is used" do
        result = activator.activatable? "href" => search_value
        expect(result).to be(true)
      end
    end

    context "with regular expression" do
      subject(:activator) { described_class.new search_value: /^admin.+/ }

      it "answers true when search values match" do
        result = activator.activatable? href: "admin/test/path"
        expect(result).to be(true)
      end

      it "answers false when search values don't match" do
        result = activator.activatable? href: "/admin/test/path"
        expect(result).to be(false)
      end

      it "answers false when no search value is supplied" do
        result = activator.activatable?
        expect(result).to be(false)
      end
    end
  end

  describe "#activate" do
    let(:path) { "/some/path" }

    context "with default settings" do
      subject { described_class.new }

      it "answers empty hash for empty parameters" do
        expect(activator.activate).to eq({})
      end

      it "answers equivalent hash for parameter hash" do
        attributes = activator.activate href: path
        proof = {"href" => path}

        expect(attributes).to eq(proof)
      end
    end

    context "with search value" do
      subject(:activator) { described_class.new search_value: path }

      it "adds target value when search and target values match" do
        attributes = activator.activate href: path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "appends target value when search and target values match" do
        attributes = activator.activate href: path, class: "example"
        proof = {"href" => path, "class" => "example active"}

        expect(attributes).to eq(proof)
      end

      it "doesn't add target value when target key isn't present" do
        attributes = activator.activate class: "example"
        proof = {"class" => "example"}

        expect(attributes).to eq(proof)
      end
    end

    context "with mixed symbol/string values" do
      it "adds target value when search key (symbol) and target key (string) values match" do
        activator = described_class.new search_value: path
        attributes = activator.activate "href" => path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value when search key (string) and target key (symbol) values match" do
        activator = described_class.new search_key: "href", search_value: path
        attributes = activator.activate href: path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end
    end

    context "with custom settings" do
      it "adds target value for custom search key" do
        activator = described_class.new search_key: "data-url", search_value: path
        attributes = activator.activate "data-url" => path
        proof = {"data-url" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value for custom target key" do
        activator = described_class.new search_value: path, target_key: "data-class"
        attributes = activator.activate href: path
        proof = {"href" => path, "data-class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value for custom target value" do
        activator = described_class.new search_value: path, target_value: "custom"
        attributes = activator.activate href: path
        proof = {"href" => path, "class" => "custom"}

        expect(attributes).to eq(proof)
      end
    end
  end
end
