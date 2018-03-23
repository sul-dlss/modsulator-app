require File.dirname(__FILE__) + '/config/boot.rb'
require 'honeybadger'

use Rack::CommonLogger, LOG
use Rack::ShowExceptions

run Spreadsheet::ModsulatorAPI
