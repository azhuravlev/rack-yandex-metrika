require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rack/test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rack/yandex-metrika'

class Test::Unit::TestCase
  include Rack::Test::Methods

  def app; Rack::Lint.new(@app); end

  def mock_app(options)
    main_app = lambda { |env|
      request = Rack::Request.new(env)
      case request.path
        when '/'          then  [200, {'Content-Type' => 'application/html'}, ['<html><head></head><body>Hello world</body></html>']]
        when '/test.xml'  then  [200, {'Content-Type' => 'application/xml'}, ['Xml here']]
        when '/head'      then  [200, {'Content-Type' => 'application/html'} ,['<head>Header only</head>']]
        else                    [404, 'Nothing here']
      end
    }

    builder = Rack::Builder.new
    builder.use Rack::YandexMetrika, options
    builder.run main_app
    @app = builder.to_app
  end
end
