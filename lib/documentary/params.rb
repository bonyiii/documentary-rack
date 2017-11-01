# coding: utf-8
module Documentary
  module Params
    attr_reader :_params

    # http://randycoulman.com/blog/2013/10/01/configuration-blocks/
    def params(action, &block)
      @params ||= {}
      @params[action.to_s] = MyParams.new(&block)

      puts @params.inspect
    end

    def print_params
      @params
    end
  end

  class MyParams
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
