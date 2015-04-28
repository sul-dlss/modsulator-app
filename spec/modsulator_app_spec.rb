require 'spec_helper'

describe Spreadsheet::ModsulatorAPI do
  def app
    @app ||= Spreadsheet::ModsulatorAPI
  end

  it "handles simple ping requests to /about" do
    get '/v1/about'
    expect(last_response).to be_ok
    expected_version = File.read(File.expand_path('../../VERSION', __FILE__))
    expect(last_response.body).to eq(String.new('modsulator-api version ' + expected_version))
  end

  it "handles simple ping requests to /modsulator_version" do
    get '/v1/modsulator_version'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/\d\.\d\.\d$/)
  end
end
