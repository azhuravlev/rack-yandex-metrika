# This module holds all instance methods to be
# included into ActionController::Base class
# for enabling yandex metrika var tracking in a Rails app.
#
require "erb"

module YandexMetrika
  module InstanceMethods

    private

    def counter_params
      self.env["yandex_metrika.visit_params"] ||= []
    end

    def reach_goals
      self.env["yandex_metrika.reach_goals"] ||= []
    end

    protected

    # Sets a counter params on a page load
    #
    # e.g. writes
    # yaCounterXXXXXX.params(yaParams);
    def ya_metrika_counter_params(name, value)
      var = YandexMetrika::CounterParam.new(name, value)
      counter_params.push(var)
    end

    # Tracks an event or goal on a page load
    #
    # e.g. writes
    # yaCounterXXXXXX.reachGoal('TARGET_NAME');
    #
    def ya_metrika_reach_goal(name, value = nil)
      var = YandexMetrika::ReachGoal.new(name, value)
      reach_goals.push(var)
    end
  end
end