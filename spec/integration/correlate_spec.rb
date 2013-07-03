require 'spec_helper'

require 'tempfile'

describe 'Correlating CCNG Request-ID with Appdirect Gateway log' do
  def fixture(fixture_name)
    File.expand_path("../../fixtures/#{fixture_name}", __FILE__)
  end

  let(:appdirect_log_file) do
    Tempfile.new('appdirect_log').tap do |f|
      f.write(File.read(fixture('appdirect_gateway.log')))
      f.close
    end
  end

  let(:ccng_log_file) do
    Tempfile.new('ccng_log').tap do |f|
      f.write(File.read(fixture('cloud_controller_ng.log')))
      f.close
    end
  end

  let(:request_guid) { 'e3141100' }

  it 'filters the appdirect gateway log' do
    output = `bin/correlate #{request_guid} #{ccng_log_file.path} #{appdirect_log_file.path}`
    $?.should be_success
    output.should eq(
      File.read(fixture('appdirect_gateway.log')) +
      File.read(fixture('cloud_controller_ng.log'))
    )
  end
end
