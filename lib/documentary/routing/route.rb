class Route
  attr_accessor :klass_name, :path, :instance_method

  def initialize(route_array)
    @path = route_array.first
    @klass_name = route_array.last[:klass]
    @instance_method = route_array.last[:method]

    handle_requires
  end

  def klass
    Module.const_get(klass_name)
  end

  def execute(env)
    if env['REQUEST_METHOD'].downcase.to_sym == :options
      Documentary::Response.new.tap do |response|
        response.status_code = 200
        response.headers = { 'Content-Type' => 'application/json' }
        response.body = klass.params[instance_method.to_sym].to_json
      end
    else
      klass.new(env).public_send(instance_method.to_sym)
    end
  end

  def handle_requires
    require File.join(File.dirname(__FILE__), '../../../', 'app', 'controllers', klass_name.downcase)
  end
end
