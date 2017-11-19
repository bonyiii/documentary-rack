# coding: utf-8
module Documentary
  module Params

    # http://randycoulman.com/blog/2013/10/01/configuration-blocks/
    def params(action = nil, &block)
      return @params unless action

      @params ||= {}
      @params[action.to_s] = Param.new(&block)

      puts @params.inspect
      @params
    end

    def print_params
      @params
    end
  end

  class Param
    def initialize(&block)
      @required = []
      @optional = []
      instance_eval(&block)
    end

    def optional(attr)
      @required << attr
    end

    def required(attr)
      @optional << attr
    end
  end
end
