module Documentary
  class BaseController
    extend Params
    # Simplify access Documentary::Response to Response
    include Documentary

    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
