module Navigator
  # Conditionally activates a tag.
  class TagActivator
    def initialize settings = {}
      @settings = settings.with_indifferent_access.reverse_merge search_key: :href,
                                                                 search_value: nil,
                                                                 target_key: :class,
                                                                 target_value: "active"
    end

    def search_key
      settings.fetch :search_key
    end

    def search_value
      settings.fetch :search_value
    end

    def target_key
      settings.fetch :target_key
    end

    def target_value
      settings.fetch :target_value
    end

    def activate attributes = {}
      attributes = attributes.with_indifferent_access

      if search_value.present? && attributes[search_key] == search_value
        attributes[target_key] = [attributes[target_key], target_value].compact * ' '
      end

      attributes
    end

    private

    attr_reader :settings
  end
end
