require 'spec_helper'

describe Spreadsheet::ModsulatorAPI do
  def app
    @app ||= Spreadsheet::ModsulatorAPI
  end

  it "handles simple ping requests to /about" do
    get '/v1/about'
    expect(last_response).to be_ok

    puts __FILE__
    
    expected_version = File.read(File.expand_path('../../VERSION', __FILE__))
    expect(last_response.body).to eq(String.new('modsulator-api version ' + expected_version))
  end
end
