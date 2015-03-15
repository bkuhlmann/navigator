module Navigator
  # Renders a HTML tag.
  class Tag
    attr_reader :name, :content

    def self.names_without_suffix
      %w(input)
    end

    def initialize name, content = nil, attributes: {}, activator: Navigator::TagActivator.new
      @name = String(name)
      @content = content
      @attributes = attributes.with_indifferent_access
      @activator = activator
    end

    def prefix
      ["<#{name}", format_attributes, '>'].compact * ''
    end

    def computed_content
      self.class.names_without_suffix.include?(name) ? nil : content
    end

    def suffix
      self.class.names_without_suffix.include?(name) ? nil : "</#{name}>"
    end

    def render
      [prefix, computed_content, suffix].compact * ''
    end

    private

    attr_reader :attributes, :activator

    def expand_data_attributes! attrs
      if attrs.key? :data
        attrs.delete(:data).each { |key, value| attrs["data-#{key}"] = value }
      end
    end

    def concatenate_attributes attrs
      activator.activate(attrs).map { |key, value| %(#{key}="#{value}") } * ' '
    end

    def format_attributes
      attrs = attributes.clone
      expand_data_attributes! attrs
      attrs = concatenate_attributes attrs
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
