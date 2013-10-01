require "active_support/json"

require 'rack/yandex-metrika'

require "tracking/counter_param"
require "tracking/reach_goal"

require "yandex-metrika/instance_methods"

ActionController::Base.send(:include, YandexMetrika::InstanceMethods) if defined?(ActionController::Base)
