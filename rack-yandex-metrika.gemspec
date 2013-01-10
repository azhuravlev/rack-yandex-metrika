# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rack/yandex-metrika/version'

Gem::Specification.new do |s|
  s.name        = "rack-yandex-metrika"
  s.version     = Rack::YandexMetrika::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ilya Konyukhov"]
  s.email       = ["ilya@konyukhov.com"]
  s.homepage    = "https://github.com/ilkon/rack-yandex-metrika"
  s.summary     = "Rack middleware to inject Yandex Metrika tracking code into outgoing responses."
  s.description = "Simple Rack middleware for implementing Yandex Metrika tracking in your Ruby-Rack based project. Supports synchronous and asynchronous insertion and configurable load options."

  s.files        = Dir.glob("lib/**/*") + %w(README.md LICENSE)
  s.require_path = 'lib'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'rack'
  s.add_development_dependency 'rack-test'
end
