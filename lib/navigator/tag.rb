# frozen_string_literal: true

module Navigator
  # Renders a HTML tag.
  class Tag
    attr_reader :name, :content

    def self.names_without_suffix = %w[img input]

    # rubocop:disable Metrics/ParameterLists
    def initialize name, content = nil, attributes: {}, activator: Navigator::TagActivator.new
      @name = String name
      @content = content
      @attributes = attributes.with_indifferent_access
      @activator = activator
    end
    # rubocop:enable Metrics/ParameterLists

    def prefix = ["<#{name}", format_attributes, ">"].compact.join

    def computed_content = self.class.names_without_suffix.include?(name) ? nil : content

    def suffix = self.class.names_without_suffix.include?(name) ? nil : "</#{name}>"

    def render = [prefix, computed_content, suffix].compact.join

    private

    attr_reader :attributes, :activator

    def expand_data_attributes! attrs
      return unless attrs.key? :data

      attrs.delete(:data).each { |key, value| attrs["data-#{key}"] = value }
    end

    def concatenate_attributes attrs
      activator.activate(attrs)
               .map { |key, value| %(#{key}="#{value}") }
               .join(" ")
    end

    def format_attributes
      attrs = attributes.clone
      expand_data_attributes! attrs
      attrs = concatenate_attributes attrs
      attrs.empty? ? nil : " #{attrs}"
    end
  end
end
