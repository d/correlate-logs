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
end
