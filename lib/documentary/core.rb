module Documentary
  class Core
    def call(env)
      route = DocumentaryApp.router.route_for(env)
      if route
        response = route.execute(env)
        return response.rack_response
      else
        return [404, {}, []]
      end
    end
  end
end
