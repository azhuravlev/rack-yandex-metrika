require 'helper'

class TestRackYandexMetrikaGoals < Test::Unit::TestCase

  context "Asyncronous With Events" do
    context "default" do
      setup do
          goals = [YandexMetrika::ReachGoal.new("Users", {:login => "Success"})]
          mock_app :async => true, :counter_id => 111, :reached_goals => goals
      end
      should "show goals" do
        get "/"

        assert_match %r{\.push\(function\(\)}, last_response.body
        assert_match %r{\{yaCounter111.reachGoal}, last_response.body
        assert_match %r{Users}, last_response.body
        assert_match %r{login}, last_response.body
        assert_match %r{Success}, last_response.body
      end

    end
  end

  context "Asyncronous With counter_params" do
    context "default" do
      setup do
        counter_params = [YandexMetrika::CounterParam.new("Items", {:removed => "Yes", :type => "Car"})]
        mock_app :async => true, :counter_id => 111, :counter_params => counter_params
      end
      
      should "show goals" do
        get "/"

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