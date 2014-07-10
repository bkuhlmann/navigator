module Navigator
  # Renders a HTML menu.
  class Menu
    def initialize template, tag = "ul", attributes = {}, menu_activator = Navigator::TagActivator.new, &block
      @template = template
      @tag = Tag.new tag, nil, attributes, menu_activator
      @menu_activator = menu_activator
      @items = []
      instance_eval(&block) if block_given?
    end

    def add name, content = nil, attributes = {}, activator = menu_activator, &block
      tag = Tag.new name, content, attributes, activator
      if block_given?
        items << tag.prefix
        items << tag.content
        instance_eval(&block)
        items << tag.suffix
      else
        items << tag.render
      end
    end

    def item content, url, item_attributes = {}, link_attributes = {}, activator = menu_activator
      link_attributes.reverse_merge! href: url

      if link_attributes[:href] == activator.search_value
        item_attributes[activator.target_key] = activator.target_value
      end

      add "li", nil, item_attributes, activator do
        add "a", content, link_attributes, Navigator::TagActivator.new
      end
    end

    def method_missing name, *args, &block
      case name.to_s
        when %r(^(h[1-6]|ul|li|a|b|em|s|small|span|strong|sub|sup)$)
          add(*args.unshift(name), &block)
        else
          template.public_send name, *args
      end
    end

    def render
      [tag.prefix, tag.content, items.compact.join(''), tag.suffix].compact * ''
    end

    private

    attr_accessor :template, :tag, :menu_activator, :items
  end
end
