require "spec_helper"

describe Navigator::TagActivator do
  subject { Navigator::TagActivator.new }

  describe "#search_key" do
    it "answers default key" do
      expect(subject.search_key).to eq(:href)
    end

    it "answers custom key" do
      subject = Navigator::TagActivator.new search_key: "data-url"
      expect(subject.search_key).to eq("data-url")
    end
  end

  describe "#search_value" do
    it "answers default value" do
      expect(subject.search_value).to eq(nil)
    end

    it "answers custom value" do
      subject = Navigator::TagActivator.new search_value: "custom"
      expect(subject.search_value).to eq("custom")
    end
  end

  describe "#target_key" do
    it "answers default key" do
      expect(subject.target_key).to eq(:class)
    end

    it "answers custom key" do
      subject = Navigator::TagActivator.new target_key: "data-url"
      expect(subject.target_key).to eq("data-url")
    end
  end

  describe "#target_value" do
    it "answers default value" do
      expect(subject.target_value).to eq("active")
    end

    it "answers custom value" do
      subject = Navigator::TagActivator.new target_value: "custom"
      expect(subject.target_value).to eq("custom")
    end
  end

  describe "activatable?" do
    let(:search_value) { "/example/path" }
    subject { Navigator::TagActivator.new search_value: search_value }

    context "with search value" do
      it "answers true when search value is found" do
        result = subject.activatable? href: search_value
        expect(result).to eq(true)
      end

      it "answers false when search value is not found" do
        result = subject.activatable? href: "/unknown/path"
        expect(result).to eq(false)
      end
    end

    context "without search value" do
      subject { Navigator::TagActivator.new }

      it "answers false with attributes" do
        result = subject.activatable? href: search_value
        expect(result).to eq(false)
      end

      it "answers false without attributes" do
        result = subject.activatable?
        expect(result).to eq(false)
      end
    end

    context "with indifferent access" do
      it "answers true when string attribute key is used" do
        result = subject.activatable? "href" => search_value
        expect(result).to eq(true)
      end
    end

    context "with regular expression" do
      subject { Navigator::TagActivator.new search_value: /^admin.+/ }

      it "answers true when search values match" do
        result = subject.activatable? href: "admin/test/path"
        expect(result).to eq(true)
      end

      it "answers false when search values don't match" do
        result = subject.activatable? href: "/admin/test/path"
        expect(result).to eq(false)
      end

      it "answers false when no search value is supplied" do
        result = subject.activatable?
        expect(result).to eq(false)
      end
    end
  end

  describe "#activate" do
    let(:path) { "/some/path" }

    context "with default settings" do
      subject { Navigator::TagActivator.new }

      it "answers empty hash for empty parameters" do
        expect(subject.activate).to eq({})
      end

      it "answers equivalent hash for parameter hash" do
        attributes = subject.activate href: path
        proof = {"href" => path}

        expect(attributes).to eq(proof)
      end
    end

    context "with search value" do
      subject { Navigator::TagActivator.new search_value: path }

      it "adds target value when search and target values match" do
        attributes = subject.activate href: path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "appends target value when search and target values match" do
        attributes = subject.activate href: path, class: "example"
        proof = {"href" => path, "class" => "example active"}

        expect(attributes).to eq(proof)
      end

      it "doesn't add target value when target key isn't present" do
        attributes = subject.activate class: "example"
        proof = {"class" => "example"}

        expect(attributes).to eq(proof)
      end
    end

    context "with mixed symbol/string values" do
      it "adds target value when search key (symbol) and target key (string) values match" do
        subject = Navigator::TagActivator.new search_value: path
        attributes = subject.activate "href" => path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value when search key (string) and target key (symbol) values match" do
        subject = Navigator::TagActivator.new search_key: "href", search_value: path
        attributes = subject.activate href: path
        proof = {"href" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end
    end

    context "with custom settings" do
      it "adds target value for custom search key" do
        subject = Navigator::TagActivator.new search_key: "data-url", search_value: path
        attributes = subject.activate "data-url" => path
        proof = {"data-url" => path, "class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value for custom target key" do
        subject = Navigator::TagActivator.new search_value: path, target_key: "data-class"
        attributes = subject.activate href: path
        proof = {"href" => path, "data-class" => "active"}

        expect(attributes).to eq(proof)
      end

      it "adds target value for custom target value" do
        subject = Navigator::TagActivator.new search_value: path, target_value: "custom"
        attributes = subject.activate href: path
        proof = {"href" => path, "class" => "custom"}

        expect(attributes).to eq(proof)
      end
    end
  end
end
