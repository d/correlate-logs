require 'spec_helper'
require 'ccng_log_record'

describe CcngLogRecord do
  subject { described_class.new(line) }
  context 'valid line' do
    let(:line) do
      <<-EOS
10.10.16.19 --  {"timestamp":1372829110.0706873,"message":"resource_pool.download.using-cdn","log_level":"debug","source":"cc.resource_pool","data":{"request_guid":"e97de039-e69e-4964-aea1-edc5d2e4da6d"},"thread_id":30805320,"fiber_id":35938580,"process_id":7922,"file":"/var/vcap/packages/cloud_controller_ng/cloud_controller_ng/lib/cloud_controller/resource_pool.rb","lineno":125,"method":"overwrite_destination_with!"}
      EOS
    end
    its(:timestamp) { should eq(Time.at(1372829110.0706873)) }
    its(:request_guid) { should eq('e97de039-e69e-4964-aea1-edc5d2e4da6d') }
    its(:line) { should eq(line) }
  end

  context 'valid line without request guid' do
    let(:line) do
      <<-'EOS'
10.10.16.13 --  {"timestamp":1372809596.7961752,"message":"Sending registration: {:host=>\"10.10.16.13\", :port=>9022, :uris=>[\"ccng.run.pivotal.io\", \"api.run.pivotal.io\"], :tags=>{:component=>\"CloudController\"}}","log_level":"debug","source":"cf.registrar","data":{},"thread_id":19160760,"fiber_id":38839800,"process_id":7154,"file":"/var/vcap/packages/cloud_controller_ng/cloud_controller_ng/vendor/bundle/ruby/1.9.1/gems/vcap_common-2.2.0/lib/cf/registrar.rb","lineno":95,"method":"send_registration_message"}
      EOS
    end

    its(:request_guid) { should be_nil }
  end
end
