require File.dirname(__FILE__) + '/config/boot.rb'
require 'honeybadger'

use Rack::CommonLogger, LOG
use Rack::ShowExceptions

# Configure and start Honeybadger
honeybadger_config = Honeybadger::Config.new(env: ENV['RACK_ENV'])
Honeybadger.start(honeybadger_config)

# And use Honeybadger's rack middleware
use Honeybadger::Rack::ErrorNotifier, honeybadger_config
use Honeybadger::Rack::MetricsReporter, honeybadger_config

run Spreadsheet::ModsulatorAPI
