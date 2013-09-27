require "active_support/json"

module YandexMetrika

  # A Struct that mirrors the structure of a counter goals defined in Yandex.Metrika
  # see http://help.yandex.ru/metrika/objects/reachgoal.xml
  class ReachGoal < Struct.new(:name, :value)
    def write
      [self.name, self.value].to_json
    end
  end
end