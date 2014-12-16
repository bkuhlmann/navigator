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
      attributes = attributes.with_indifferent_access
      search_value.present? && attributes[search_key] == search_value
    end

    def activate attributes = {}
      attributes = attributes.with_indifferent_access

      if activatable? attributes
        attributes[target_key] = [attributes[target_key], target_value].compact * ' '
      end

      attributes
    end
  end
end
