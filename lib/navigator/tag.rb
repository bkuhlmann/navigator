module Navigator
  # Renders a HTML tag.
  class Tag
    attr_reader :name, :content, :attributes

    def initialize name, content = nil, attributes = {}
      @name, @content, @attributes = name, content, attributes
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

    def formatted_attributes
      attrs = attributes.map { |key, value| %(#{key}="#{value}") } * ' '
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
