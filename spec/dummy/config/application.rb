require File.expand_path("../boot", __FILE__)

# Pick the frameworks you want:
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require
require "navigator"

module Dummy
  class Application < Rails::Application
  end
end
