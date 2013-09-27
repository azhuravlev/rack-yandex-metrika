$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rack'
require 'rack/test'
require 'active_support/core_ext/hash/slice'
require "action_controller"
require File.expand_path('../../lib/rack-yandex-metrika', __FILE__)

class TestRackYandexMetrikaInstanceMethods < Test::Unit::TestCase

  include Rack::Test::Methods

  class MockController < ActionController::Base
    def index
      ya_metrika_counter_params("Items", {:removed => "Yes", :type => "Car"})
      ya_metrika_reach_goal("Users", {:login => "Success"})
      render :inline => "<html><head><title>Title</title></head><body>Hello World</body></html>"
    end

    def action_method?(name)
      true
    end
  end

  def controller
    MockController.action(:index)
  end

  # Build an app to call our MockController with YandexMetrika middleware
  def mock_app(options)
    builder = Rack::Builder.new
    builder.use Rack::YandexMetrika, options
    builder.run controller
    @app = builder.to_app
  end

  def app;
    Rack::Lint.new(@app);
  end

  context "Instance Methods" do
    setup { mock_app :async => true, :counter_id => 111 }

    context "pass params to rack" do

      should "have goal tracking" do
        get "/"
        assert last_response.ok?

        assert_match %r{\.push\(function\(\)}, last_response.body
        assert_match %r{w\.yaCounter111.reachGoal}, last_response.body
        assert_match %r{Users}, last_response.body
        assert_match %r{login}, last_response.body
        assert_match %r{Success}, last_response.body
      end

      should "have counter_params" do
        get "/"
        assert last_response.ok?

        assert_match %r{\.push\(function\(\)}, last_response.body
        assert_match %r{w\.yaCounter111.params}, last_response.body
        assert_match %r{Items}, last_response.body
        assert_match %r{removed}, last_response.body
        assert_match %r{Yes}, last_response.body
        assert_match %r{type}, last_response.body
        assert_match %r{Car}, last_response.body
      end
    end
  end

end