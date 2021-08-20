# frozen_string_literal: true

module Navigator
  # Renders a HTML menu.
  class Menu
    ALLOWED_ELEMENTS = /
      ^(
      div|
      section|
      header|
      h[1-6]|
      nav|
      ul|
      li|
      a|
      img|
      b|
      em|
      s|
      small|
      span|
      strong|
      sub|
      sup|
      form|
      label|
      select|
      option|
      input|
      button
      )$
    /x

    def initialize template,
                   tag: "ul",
                   attributes: {},
                   activator: Navigator::TagActivator.new,
                   &block

      @template = template
      @tag = Navigator::Tag.new tag, attributes: attributes, activator: activator
      @menu_activator = activator
      @items = []
      instance_eval(&block) if block
    end

    def add name, content = nil, attributes: {}, activator: menu_activator, &block
      tag = Navigator::Tag.new name, content, attributes: attributes, activator: activator
      return items << tag.render unless block

      items << tag.prefix
      items << tag.content
      instance_eval(&block)
      items << tag.suffix
    end

    def link content = nil, url, attributes: {}, activator: menu_activator, &block
      add "a", content, attributes: attributes.merge(href: url), activator: activator, &block
    end

    def image url, alt = nil, attributes: {}, activator: menu_activator
      modified_attributes = attributes.merge src: url, alt: alt
      modified_attributes = modified_attributes.delete_if { |_, value| !value.present? }

      add "img", attributes: modified_attributes, activator: activator
    end

    def item content = nil,
             url,
             item_attributes: {},
             link_attributes: {},
             activator: menu_activator,
             &block

      modified_item_attributes = item_attributes.clone
      activate_item_attributes! modified_item_attributes, url, activator

      add "li", attributes: modified_item_attributes, activator: activator do
        link content,
             url,
             attributes: link_attributes,
             activator: Navigator::TagActivator.new,
             &block
      end
    end

    def method_missing name, *positionals, **keywords, &block
      if respond_to_missing? name
        add(name, *positionals, **keywords, &block)
      else
        template.public_send(name, *positionals, **keywords) || super
      end
    end

    def render = [tag.prefix, tag.content, items.compact.join, tag.suffix].compact.join

    private

    attr_accessor :template, :tag, :menu_activator, :items

    def respond_to_missing?(name, include_private = false) = ALLOWED_ELEMENTS.match?(name) || super

    def activate_item_attributes! attributes, url, activator
      return unless url == activator.search_value

      key = [attributes[activator.target_key], activator.target_value].compact.join " "
      attributes[activator.target_key] = key
    end
  end
end
