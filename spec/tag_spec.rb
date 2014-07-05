require "spec_helper"

describe Navigator::Tag do
  let(:tag) { Navigator::Tag.new "li", "Example text.", class: "example" }

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

    it "answers prefix with multiple attributes" do
      tag = Navigator::Tag.new "li", nil, class: "tooltip", "data-enabled" => true
      expect(tag.prefix).to eq('<li class="tooltip" data-enabled="true">')
    end

    context "active default attribute" do
      it "adds target value when search and target values match" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}, {search_value: "/some/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path" class="active">))
      end

      it "adds target value when search (symbol key) and target (string key) values match" do
        tag = Navigator::Tag.new "a", nil, {"href" => "/some/path"}, {search_value: "/some/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path" class="active">))
      end

      it "adds target value when search (string key) and target (symbol key) values match" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}, {"search_value" => "/some/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path" class="active">))
      end

      it "adds target value when search key value (string) and target key (symbol) match" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"},
                                           {"search_key" => "href", "search_value" => "/some/path"}

        expect(tag.prefix).to eq(%(<a href="/some/path" class="active">))
      end

      it "appends target value when search and target values match" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path", class: "example"}, {search_value: "/some/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path" class="example active">))
      end

      it "doesn't add target value when search value isn't present" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path">))
      end

      it "doesn't add target value when target key isn't present" do
        tag = Navigator::Tag.new "a", nil, {}, {search_value: "/some/path"}
        expect(tag.prefix).to eq(%(<a>))
      end

      it "doesn't add target value when search and target values don't match" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}, {search_value: "/some/other/path"}
        expect(tag.prefix).to eq(%(<a href="/some/path">))
      end
    end

    context "active custom attribute" do
      it "adds target value for custom search key" do
        tag = Navigator::Tag.new "span", nil, {"data-url" => "/some/path"},
                                              {search_key: "data-url", search_value: "/some/path"}

        expect(tag.prefix).to eq(%(<span data-url="/some/path" class="active">))
      end

      it "adds target value for custom target key" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}, {search_value: "/some/path", target_key: "data-id"}
        expect(tag.prefix).to eq(%(<a href="/some/path" data-id="active">))
      end

      it "adds target value for custom target value" do
        tag = Navigator::Tag.new "a", nil, {href: "/some/path"}, {search_value: "/some/path", target_value: "custom"}
        expect(tag.prefix).to eq(%(<a href="/some/path" class="custom">))
      end
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
      expect(tag.render).to eq('<li class="example">Example text.</li>')
    end
  end
end
