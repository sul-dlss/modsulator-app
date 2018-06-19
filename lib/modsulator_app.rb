require 'json'
require 'modsulator'

module Spreadsheet
  class ModsulatorAPI < Grape::API

    version 'v1', :using => :path

    format :txt
    default_format :txt

    resource :about do
      # Simple ping to see if the application is up
      # GET http://localhost:9292/v1/about
      get do
        @version ||= IO.readlines('VERSION').first
        "modsulator-api version #{@version}"
      end
    end

    resource :modsulator do
      get do
        @version ||= IO.readlines('VERSION').first
        "modsulator-api version #{@version}"
      end

      # curl --form  file=@Fitch_Chavez.xml http://localhost:9292/v1/modsulator
      post do
        header 'Content-Type', 'application/xml'
        mods_converter = Modsulator.new(File.new(params[:file][:tempfile]), params[:filename])
        mods_converter.convert_rows()
      end
    end

    resource :normalizer do
      get do
        @version ||= IO.readlines('VERSION').first
        "normalizer-api version #{@version}"
      end

      # POST http://localhost:9292/v1/normalizer
      post do
        input_file = File.open(params[:file][:tempfile])
        xml = input_file.read
        input_file.close
        header 'Content-Type', 'application/xml'
        normalizer = Stanford::Mods::Normalizer.new
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
        IO.read(Modsulator.template_spreadsheet_path, mode: 'rb')
      end
    end
  end #class
end # module
