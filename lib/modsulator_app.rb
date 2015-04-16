require 'json'
require 'modsulator'
require 'modsulator/normalizer'

module Spreadsheet

  class ModsulatorAPI < Grape::API

    version 'v1', :using => :path

    format :txt
    default_format :txt

    rescue_from :all do |e|
      logger.error("Caught an exception: #{e.message}")
      logger.error(e.backtrace.join("\n"))
      error!("Caught an exception: #{e.message}")
    end

    logger LOG

    helpers do
      def logger
        ModsulatorAPI.logger
      end
    end

    resource :about do
      # Simple ping to see if the application is up
      # GET http://localhost:9292/v1/about
      get do
        logger.info("Got a GET /v1/about request")
        "ok!\n"
      end
    end

    resource :modsulator do

      # POST http://localhost:9292/v1/modsulator
      post do

        # When the format is specified above as json, params['rows'] is an array of hashes, so Grape actually
        # builds a proper hash from the supplied JSON that would be appropriate to pass to Modsulator
        # When the format is specified above as txt, 'request.content_type' will be the Content-Type header value
        # (e.g. application/json or text/plain). In that case, you can create a (JSON) hash using 'JSON.parse(request.body.read)'.
        logger.info("got POST")
        json_hash = JSON.parse(request.body.read)
        mods_converter = Modsulator.new('', json_hash['rows'])
        mods_converter.convert_rows
      end
    end

    resource :normalizer do

      # POST http://localhost:9292/v1/normalizer
      post do
        normalizer = Normalizer.new
        normalizer.normalize_xml_string(request.body.read)
      end
    end

    resource :version do

      # GET http://localhost:9292/v1/version
      get do
        Gem.loaded_specs['modsulator'].version.version
      end
    end
    

  end #class

end # module
