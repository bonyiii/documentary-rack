require File.join(File.dirname(__FILE__), 'router')
require File.join(File.dirname(__FILE__), 'response')
require File.join(File.dirname(__FILE__), 'params')

class BrainRack
  attr_reader :router

  def initialize
    @router = Router.new
  end
end
