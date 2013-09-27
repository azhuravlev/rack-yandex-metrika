require "active_support/json"

module YandexMetrika
  class Push

    def initialize(attributes)
      @attributes = attributes
    end

    def write
      @attributes.to_json
    end
  end
end