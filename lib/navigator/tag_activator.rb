module Navigator
  # Conditionally activates a tag.
  class TagActivator
    attr_reader :search_key, :search_value, :target_key, :target_value

    def initialize search_key: :href, search_value: nil, target_key: :class, target_value: "active"
      @search_key = search_key
      @search_value = search_value
      @target_key = target_key
      @target_value = target_value
    end

    def activatable? attributes = {}
      return false unless search_value.present?

      attributes = attributes.with_indifferent_access
      current_search_value = attributes[search_key]

      if current_search_value.is_a?(Regexp) || search_value.is_a?(Regexp)
        !!(current_search_value =~ search_value)
      else
        current_search_value == search_value
      end
    end

    def activate attributes = {}
      attributes = attributes.with_indifferent_access
      attributes[target_key] = [attributes[target_key], target_value].compact.join(' ') if activatable? attributes
      attributes
    end
  end
end
