module Navigator
  # Renders a HTML tag.
  class Tag
    attr_reader :name, :content

    def initialize name, content = nil, attributes = {}, settings = {}
      @name = name
      @content = content
      @attributes = attributes.with_indifferent_access
      @settings = settings.with_indifferent_access.reverse_merge search_key: :href,
                                                                 search_value: nil,
                                                                 target_key: :class,
                                                                 target_value: "active"
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

    attr_reader :attributes, :settings

    def activate_attribute
      search_key = settings.fetch :search_key
      search_value = settings.fetch :search_value

      if search_value.present? && attributes[search_key] == search_value
        target_key = settings.fetch :target_key
        target_value = settings.fetch :target_value
        attributes[target_key] = [attributes[target_key], target_value].compact * ' '
      end
    end

    def formatted_attributes
      activate_attribute
      attrs = attributes.map { |key, value| %(#{key}="#{value}") } * ' '
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
