module Navigator
  # Renders a HTML menu. Examples:
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
    def initialize template, tag = "ul", attributes = {}, tag_activator = Navigator::TagActivator.new, &block
      @template = template
      @tag = Tag.new tag, nil, attributes, tag_activator
      @items = []
      instance_eval(&block) if block_given?
    end

    def add name, content = nil, attributes = {}, &block
      tag = Tag.new name, content, attributes
      if block_given?
        items << tag.prefix
        items << tag.content
        instance_eval(&block)
        items << tag.suffix
      else
        items << tag.render
      end
    end

    def item content, url, item_attributes = {}, link_attributes = {}
      add "li", nil, item_attributes do
        add "a", content, {href: url}.reverse_merge(link_attributes)
      end
    end

    def method_missing name, *args, &block
      case name.to_s
        when %r(^(ul|li|a|b|em|s|small|span|strong|sub|sup)$)
          add(*args.unshift(name), &block)
        else
          template.public_send name, *args
      end
    end

    def render
      [tag.prefix, tag.content, items.compact.join(''), tag.suffix].compact * ''
    end

    private

    attr_accessor :template, :tag, :items
  end
end
