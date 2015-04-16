require File.dirname(__FILE__) + '/config/boot.rb'

use Rack::CommonLogger
use Rack::ShowExceptions
run Spreadsheet::ModsulatorAPI
