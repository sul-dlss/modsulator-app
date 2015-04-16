environment = ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

LOG = Logger.new(File.join(File.dirname(__FILE__), "..", "log", "modsulator.log"))

require 'modsulator_app'
