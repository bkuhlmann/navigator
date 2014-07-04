module Navigator
  # Represents a HTML tag.
  class Tag
    attr_reader :name, :content, :attributes

    # Initalizes the HTML tag.
    # ==== Parameters
    # * +name+ - Required. The tag name.
    # * +content+ - Optional. The tag content. Default: nil
    # * +attributes+ - Optional. The tag attributes. Default: {}
    def initialize name, content = nil, attributes = {}
      @name, @content, @attributes = name, content, attributes
    end

    # Answers the attributes as fully formed HTML attributes for the tag.
    def html_attributes
      attributes.map { |key, value| %(#{key}="#{value}") }.compact * ' '
    end

    # Answers the HTML tag prefix (i.e. the opening tag). Example: <li>.
    def prefix
      attrs = html_attributes.empty? ? nil : " #{html_attributes}"
      ["<#{name}", attrs, '>'].compact * ''
    end

    # Answers the HTML tag suffix (i.e. the closing tag). Example: </li>.
    def suffix
      "</#{name}>"
    end

    # Renders the fully assembled HTML tag with attributes and content (if apt).
    def render
      [prefix, content, suffix].compact * ''
    end
  end
end
