# coding: utf-8
module Documentary
  module Params

    # http://randycoulman.com/blog/2013/10/01/configuration-blocks/
    def params(action = nil, **args, &block)
      return @params unless action

      @params ||= {}
      @params[action] = ParamBuilder.build(&block)

      puts @params.inspect
      @params
    end

    def print_params
      @params
    end
  end

  class ParamBuilder
    attr_reader :hash

    def self.build(&block)
      new.tap { |param_builder| param_builder.instance_eval(&block) }.hash
    end

    def initialize()
      @hash = {}
    end

    def required(meth, **args, &block)
      @hash[meth] = block ? self.class.build(&block) : args
      @hash[meth][:required] = true
    end

    def optional(meth, **args, &block)
      @hash[meth] = block ? self.class.build(&block) : args
      @hash[meth][:required] = false
    end
  end
end
