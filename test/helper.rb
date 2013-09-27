require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rack/test'
require 'active_support/core_ext/hash/slice'
require File.expand_path('../../lib/yandex-metrika/instance_methods', __FILE__)
require File.expand_path('../../lib/tracking/counter_param', __FILE__)
require File.expand_path('../../lib/tracking/reach_goal', __FILE__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rack/yandex-metrika'

class Test::Unit::TestCase
  include Rack::Test::Methods

  def app; 
    Rack::Lint.new(@app); 
  end

  def main_app(options)
    main_app = lambda { |env|
      env["yandex_metrika.visit_params"] = options[:counter_params] if options[:counter_params]
      env["yandex_metrika.reach_goals"] = options[:reached_goals] if options[:reached_goals]

      request = Rack::Request.new(env)
      case request.path
        when '/'          then  [200, {'Content-Type' => 'application/html'}, ['<html><head></head><body>Hello world</body></html>']]
        when '/test.xml'  then  [200, {'Content-Type' => 'application/xml'}, ['Xml here']]
        when '/body'      then  [200, {'Content-Type' => 'application/html'} ,['<body>bob here</body>']]
        else                    [404, 'Nothing here']
      end
    }
  end

  def mock_app(options)
    app_options = options.slice(:counter_params, :reached_goals)

    builder = Rack::Builder.new
    builder.use Rack::YandexMetrika, options
    builder.run main_app(app_options)
    @app = builder.to_app
  end  
end
