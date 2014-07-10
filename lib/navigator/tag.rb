module Navigator
  # Renders a HTML tag.
  class Tag
    attr_reader :name, :content

    def initialize name, content = nil, attributes = {}, activator = Navigator::TagActivator.new
      @name = name
      @content = content
      @attributes = attributes.with_indifferent_access
      @activator = activator
    end

    def prefix
      ["<#{name}", formatted_attributes, '>'].compact * ''
    end

    def suffix
      "</#{name}>"
    end

    def render
      [prefix, content, suffix].compact * ''
    end

    private

    attr_reader :attributes, :activator

    def expand_data_attributes!
      if attributes.key? :data
        attributes[:data].each { |key, value| attributes["data-#{key}"] = value }
        attributes.delete :data
      end
    end

    def formatted_attributes
      expand_data_attributes!
      attrs = activator.activate(attributes).map { |key, value| %(#{key}="#{value}") } * ' '
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
