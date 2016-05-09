require 'json'
require 'modsulator'
require 'modsulator/normalizer'
require './profiler'

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
        # LOG.error("Tommy: here")
        # LOG.error("Tommy: params = #{params}")
        # LOG.error("Tommy: inspect #{params[:file].inspect}")
        # LOG.error("Tommy: received fileparams = #{params[:file]} and tempfile = #{params[:file][:tempfile]} and filename = #{params[:filename]}")
        mods_converter = Modsulator.new(File.new(params[:file][:tempfile]), params[:filename])
        # LOG.error("Tommy: mods_converter = #{mods_converter}")
        mods_converter.convert_rows()
        # LOG.error("Tommy: completed and result its #{result}")
        # result
      end
    end

    resource :normalizer do

      # POST http://localhost:9292/v1/normalizer
      post do
        p = Profiler.new
        p.prof do 
          LOG.error("Tommy: starting")
          normalizer = Normalizer.new
          LOG.error("Tommy: have a normalizer")
          #outs = File.open("/tmp/received_file", "w")
          input_file = File.open(params[:file][:tempfile])
          xml = input_file.read
          LOG.error("Tommy: read the XML")
          input_file.close
          #outs.puts("Tommy: file = #{xml}")
          
          LOG.error("Tommy about to normalize")
          normalizer.normalize_xml_string(xml)
          #outs.puts("Tommy: result = #{result}")  -- use rubyprof? or other profiling tool? new relic? see argo github
          #outs.close
          #LOG.error("Tommy: finished")
          #result
        end

        p.print_results_call_tree("#{DateTime.now}.prof")
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
