require File.join(File.dirname(__FILE__), 'route')

module Documentary
  class Router
    attr_reader :routes

    def initialize
      @routes = Hash.new { |hash, key| hash[key] = [] }
    end

    def config(&block)
      instance_eval &block
    end

    [:get, :patch, :post, :put].each do |name|
      define_method(name) do |path, options = {}|
        @routes[name] << [path, parse_to(options[:to])]
      end
    end

    def route_for(env)
      path = env['PATH_INFO']
      method = env['REQUEST_METHOD'].downcase.to_sym

      if method == :options
        method = (env['OPTIONS_METHOD'] || :get).downcase.to_sym
      end

      route_array = routes[method].detect do |route|
        case route.first
        when String
          path == route.first
        when Regexp
          path =~ route.first
        end
      end

      return Route.new(route_array) if route_array
      return nil
    end

    private

    def parse_to(to_string)
      klass, method = to_string.split("#")
      { klass: klass.capitalize, method: method }
    end
  end
end
