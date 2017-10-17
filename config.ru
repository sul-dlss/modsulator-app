require File.dirname(__FILE__) + '/config/boot.rb'
require 'honeybadger'

use Rack::CommonLogger, LOG
use Rack::ShowExceptions

# Configure and start Honeybadger
honeybadger_config = Honeybadger::Config.new(env: ENV['RACK_ENV'])
Honeybadger.start(honeybadger_config)

run Spreadsheet::ModsulatorAPI
