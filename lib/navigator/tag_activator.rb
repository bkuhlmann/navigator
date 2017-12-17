# frozen_string_literal: true

module Navigator
  # Conditionally activates a tag.
  class TagActivator
    attr_reader :search_key, :search_value, :target_key, :target_value

    # rubocop:disable Metrics/ParameterLists
    def initialize search_key: :href, search_value: nil, target_key: :class, target_value: "active"
      @search_key = search_key
      @search_value = search_value
      @target_key = target_key
      @target_value = target_value
    end
    # rubocop:enable Metrics/ParameterLists

    # :reek:TooManyStatements
    def activatable? attributes = {}
      return false unless search_value.present?

      attributes = attributes.with_indifferent_access
      current_search_value = attributes[search_key]

      if current_search_value.is_a?(Regexp) || search_value.is_a?(Regexp)
        return false if current_search_value.blank?
        current_search_value.match? search_value
      else
        current_search_value == search_value
      end
    end

    # rubocop:disable Metrics/LineLength
    def activate attributes = {}
      attributes = attributes.with_indifferent_access
      attributes[target_key] = [attributes[target_key], target_value].compact.join(" ") if activatable? attributes
      attributes
    end
    # rubocop:enable Metrics/LineLength
  end
end
