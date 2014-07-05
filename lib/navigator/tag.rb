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

    def formatted_attributes
      attrs = activator.activate(attributes).map { |key, value| %(#{key}="#{value}") } * ' '
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
