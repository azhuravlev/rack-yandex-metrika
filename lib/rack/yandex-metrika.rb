require 'rack'
require 'erb'

module Rack
  class YandexMetrika
    GOALS_KEY = "yandex_metrika.reach_goals"

    DEFAULT = { :async => true }

    def initialize(app, options = {})
      raise ArgumentError, "Counter_id must be set!" unless options[:counter_id] and options[:counter_id] != 0
      @app, @options = app, DEFAULT.merge(options)
    end

    def call(env); dup._call(env); end

    def _call(env)
      @status, @headers, @body = @app.call(env)
      return [@status, @headers, @body] unless html?
      response = Rack::Response.new([], @status, @headers)
      
      @options[:counter_params] = env["yandex_metrika.visit_params"] || []

      if response.ok?
        # Write out the events now
        @options[:reached_goals] = env[GOALS_KEY] || []

        # Get any stored events from a redirection
        session = env["rack.session"]
        stored_events = session.delete(GOALS_KEY) if session
        @options[:reached_goals] += stored_events unless stored_events.nil?
      elsif response.redirection?
        # Store the events until next time
        env["rack.session"][GOALS_KEY] = env[GOALS_KEY]
      end

      @body.each { |fragment| response.write inject(fragment) }
      @body.close if @body.respond_to?(:close)
      
      response.finish
    end

  private

    def html?; @headers['Content-Type'] =~ /html/; end

    def inject(response)
      file = @options[:async] ? 'async' : 'sync'

      @template ||= ::ERB.new ::File.read ::File.expand_path("../templates/#{file}.erb", __FILE__)
      if @options[:async]
        response.gsub(%r{</head>}, @template.result(binding) + "</head>")
      else
        response.gsub(%r{</body>}, @template.result(binding) + "</body>")
      end
    end
  end
end
