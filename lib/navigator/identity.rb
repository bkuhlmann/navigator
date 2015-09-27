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
      "1.3.0"
    end

    def self.label_version
      [label, version].join " "
    end
  end
end
