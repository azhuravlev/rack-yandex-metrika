require 'rack'
require 'erb'

module Rack
  class YandexMetrika
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
      @body.each { |fragment| response.write inject(fragment) }
      @body.close if @body.respond_to?(:close)
      response.finish
    end

  private

    def html?; @headers['Content-Type'] =~ /html/; end

    def inject(response)
      file = @options[:async] ? 'async' : 'sync'
      @template ||= ::ERB.new ::File.read ::File.expand_path("../templates/#{file}.erb", __FILE__)
      response.gsub(%r{</body>}, @template.result(binding) + "</body>")
    end
  end
end
