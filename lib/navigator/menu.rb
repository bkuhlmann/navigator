module Navigator
  # Builds and renders HTML menus. Examples:
  # Example 1:
  # <ul>
  #   <li>One</li>
  #   <li>Two</li>
  # </ul>
  # Example 2:
  # <nav>
  #   <a href="/one">One</a>
  #   <a href="/two">Two</a>
  # </nav>
  class Menu
    attr_accessor :options

    # Initializes the menu.
    # ==== Parameters
    # * +template+ - Required. The view template.
    # * +tag+ - Optional. The menu tag. Default: "ul"
    # * +attributes+ - Optional. The tag attributes. Default: {}
    # * +options+ - Optional. The menu options. Default: {active: "active"}
    # * +block+ - Optional. The code block.
    def initialize template, tag = "ul", attributes = {}, options = {}, &block
      @template = template
      @tag = Tag.new tag, nil, attributes
      @options = options.reverse_merge! active: "active"
      @items = []
      instance_eval(&block) if block_given?
    end

    # Adds a HTML tag to the menu.
    # ==== Parameters
    # * +name+ - Required. The tag name.
    # * +content+ - Optional. The tag content. Default: nil
    # * +attributes+ - Optional. The HTML attributes (hash) for the tag. Default: {}
    # * +block+ - Optional. The tag code block.
    def add name, content = nil, attributes = {}, &block
      tag = Tag.new name, content, attributes
      if block_given?
        @items << tag.prefix
        @items << tag.content
        instance_eval(&block)
        @items << tag.suffix
      else
        @items << tag.render
      end
    end

    # Build a list item tag (li) that contains a link tag (a).
    # This is a convenience method for adding simple list items as links.
    # ==== Parameters
    # * +content+ - Required. The content of the link (not the item!)
    # * +url+ - Required. The link url.
    # * +item_attributes+ - Optional. The item HTML attributes. Default: {}
    # * +link_attributes+ - Optional. The link HTML attributes. Default: {}
    def item content, url, item_attributes = {}, link_attributes = {}
      add "li", nil, item_attributes do
        add "a", content, {href: url}.reverse_merge!(link_attributes)
      end
    end

    # Delegates missing method names to the .add method for supported tags only.
    # Supported Tags: ul, li, a, b, em, s, small, span, strong, sub, and sup.
    # All other method calls are sent to the view template for processing (if apt).
    # ==== Parameters
    # * +name+ - Required. The method name.
    # * +args+ - Optional. The method arguments.
    # * +block+ - Optional. The code block.
    def method_missing name, *args, &block
      if name.to_s =~ /^(ul|li|a|b|em|s|small|span|strong|sub|sup)$/
        add(*args.unshift(name), &block)
      else
        @template.public_send name, *args
      end
    end

    # Renders the menu.
    def render
      [@tag.prefix, @tag.content, @items.compact.join(''), @tag.suffix].compact * ''
    end
  end
end
