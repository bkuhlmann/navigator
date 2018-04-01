# frozen_string_literal: true

module Navigator
  # Gem identity information.
  module Identity
    def self.name
      "navigator"
    end

    def self.label
      "Navigator"
    end

    def self.version
      "3.1.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
