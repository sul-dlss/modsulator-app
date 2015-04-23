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

#    logger LOG

    # helpers do
    #   def logger
    #     ModsulatorAPI.logger
    #   end
    # end

    resource :about do
      # Simple ping to see if the application is up
      # GET http://localhost:9292/v1/about
      get do
        LOG.info("Got a GET /v1/about request")
        @version ||= IO.readlines('VERSION').first
        "ok\nversion: #{@version}"
      end
    end

    resource :modsulator do

      # curl --form  file=@Fitch_Chavez.xml http://localhost:9292/v1/modsulator_upload
      post do
        mods_converter = Modsulator.new(File.new(params[:file][:tempfile]), params[:file][:filename])
        mods_converter.convert_rows()
      end
    end

    resource :normalizer do

      # POST http://localhost:9292/v1/normalizer
      post do
        normalizer = Normalizer.new
        normalizer.normalize_xml_string(request.body.read)
      end
    end

    resource :modsulator_version do

      # GET http://localhost:9292/v1/version
      get do
        Gem.loaded_specs['modsulator'].version.version
      end
    end
    

  end #class

end # module
