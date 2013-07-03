require 'spec_helper'
require 'appdirect_log_record'

describe AppdirectLogRecord do
  subject { described_class.new(line) }
  context 'valid line' do
    let(:line) do
      <<-EOS
10.10.32.10 --  [2013-07-03 05:24:11.251382] appdirect_gateway - pid=1502 tid=dd3d fid=b3df  DEBUG -- Reply status:200, headers:{"Content-Type"=>"application/json"}, body:{"configuration":{"data":{"binding_options":{}}},"credentials":{"jdbcUrl":"jdbc:mysql://b23885a6aa5d90:7c9d496c@us-cdbr-east-04.cleardb.com:3306/ad_4f590da6b19e9b4","uri":"mysql://b23885a6aa5d90:7c9d496c@us-cdbr-east-04.cleardb.com:3306/ad_4f590da6b19e9b4?reconnect=true","name":"ad_4f590da6b19e9b4","hostname":"us-cdbr-east-04.cleardb.com","port":"3306","username":"b23885a6aa5d90","password":"7c9d496c"},"service_id":"3ab70142-4f81-47e3-bf7d-454e9965e6cd"}
      EOS
    end
    its(:timestamp) { should be_within(0.001).of(Time.utc(2013, 7, 3, 5, 24, 11.251382)) }
    its(:line) { should eq(line) }
  end
end
