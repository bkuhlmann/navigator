module Navigator
  # Renders a HTML menu.
  class Menu
    def self.allowed_methods
      %r(^(section|header|h[1-6]|ul|li|a|b|em|s|small|span|strong|sub|sup)$)
    end

    def initialize template, tag: "ul", attributes: {}, activator: Navigator::TagActivator.new, &block
      @template = template
      @tag = Navigator::Tag.new tag, attributes: attributes, activator: activator
      @menu_activator = activator
      @items = []
      instance_eval(&block) if block_given?
    end

    def add name, content = nil, attributes: {}, activator: menu_activator, &block
      tag = Navigator::Tag.new name, content, attributes: attributes, activator: activator
      if block_given?
        items << tag.prefix
        items << tag.content
        instance_eval(&block)
        items << tag.suffix
      else
        items << tag.render
      end
    end

    def link content = nil, url, attributes: {}, activator: menu_activator, &block
      add "a", content, attributes: attributes.merge(href: url), activator: activator, &block
    end

    def item content = nil, url, item_attributes: {}, link_attributes: {}, activator: menu_activator, &block
      if url == activator.search_value
        item_attributes[activator.target_key] = activator.target_value
      end

      add "li", attributes: item_attributes, activator: activator do
        link content, url, attributes: link_attributes, activator: Navigator::TagActivator.new, &block
      end
    end

    def respond_to? name
      method_allowed?(name) || super(name)
    end

    def method_missing name, *args, &block
      if method_allowed?(name.to_s)
        add(name, *args, &block)
      else
        template.public_send name, *args
      end
    end

    def render
      [tag.prefix, tag.content, items.compact.join(''), tag.suffix].compact * ''
    end

    private

    attr_accessor :template, :tag, :menu_activator, :items

    def method_allowed? name
      self.class.allowed_methods === name
    end
  end
end
