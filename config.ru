require 'bundler'
Bundler.require

require File.join(File.dirname(__FILE__), 'lib', 'documentary', 'core')

class App
  attr_reader :router

  def initialize
    @router = Documentary::Router.new
  end
end
DocumentaryApp = App.new
require File.join(File.dirname(__FILE__), 'config', 'routes')

run Documentary::Core.new
