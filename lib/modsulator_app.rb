require 'json'
require 'modsulator'
require 'modsulator/normalizer'

module Spreadsheet

  class ModsulatorAPI < Grape::API

    version 'v1', :using => :path

    format :txt
    default_format :txt

    rescue_from :all do |e|
      LOG.error("Caught an exception: #{e.message}")
      LOG.error(e.backtrace.join("\n"))
      error!("Caught an exception: #{e.message}")
    end

    resource :about do
      # Simple ping to see if the application is up
      # GET http://localhost:9292/v1/about
      get do
        @version ||= IO.readlines('VERSION').first
        "modsulator-api version #{@version}"
      end
    end

    resource :modsulator do

      # curl --form  file=@Fitch_Chavez.xml http://localhost:9292/v1/modsulator
      post do
        mods_converter = Modsulator.new(File.new(params[:file][:tempfile]), params[:filename])
        mods_converter.convert_rows()
      end
    end

    resource :normalizer do

      # POST http://localhost:9292/v1/normalizer
      post do
        input_file = File.open(params[:file][:tempfile])
        xml = input_file.read
        input_file.close
        normalizer = Normalizer.new
        normalizer.normalize_xml_string(xml)
      end
    end

    resource :modsulator_version do

      # GET http://localhost:9292/v1/modsulator_version
      get do
        Gem.loaded_specs['modsulator'].version.version
      end
    end

    resource :spreadsheet do

      # GET http://localhost:9292/v1/spreadsheet
      get do
        Modsulator.get_template_spreadsheet()
      end
    end

  end #class
end # module
