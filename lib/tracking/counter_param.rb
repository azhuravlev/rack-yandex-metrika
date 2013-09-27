require "active_support/json"

module YandexMetrika

  # A Struct that mirrors the structure of a counter params defined in Yandex.Metrika
  # see http://help.yandex.ru/metrika/objects/params-method.xml
  class CounterParam < Struct.new(:name, :value)
    def write
      {self.name.to_sym => self.value}.to_json
    end
  end
end