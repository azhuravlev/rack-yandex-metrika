require "active_support/json"

module YandexMetrika

  # A Struct that mirrors the structure of a counter goals defined in Yandex.Metrika
  # see http://help.yandex.ru/metrika/objects/reachgoal.xml
  class ReachGoal < Struct.new(:name, :value)
    def write
      goal = [self.name.to_json]
      goal.push(self.value.to_json) if self.value
      goal
    end
  end
end