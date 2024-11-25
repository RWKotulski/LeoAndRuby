# lib/leoandruby.rb

require_relative "leoandruby/version"
require_relative "leoandruby/client"
require_relative "../generators/leoandruby/webhook_generator"

module LeoAndRuby
  mattr_accessor :config
  self.config = {}
end
