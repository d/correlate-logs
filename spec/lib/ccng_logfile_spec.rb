require 'spec_helper'
require 'ccng_logfile'

describe CcngLogfile do
  subject(:logfile) { described_class.new(io) }
  let(:line1) { double('line 1') }
  let(:io) { double('file', lines: [line1]) }

  describe '#records' do
    it 'parses the lines and return log records' do
      record = double('log record')
      CcngLogRecord.stub(new: record)
      logfile.records.should == [record]
    end
  end

  describe '#records_matching' do
    let(:prefix) { 'prefix' }
    let(:line2) { double(include?: false) }
    before do
      line1.stub(:include?).with(prefix).and_return(true)
      io.stub(lines: [line1, line2])
    end

    it 'returns the log records matching the request_guid prefix' do
      record = double('log record')
      CcngLogRecord.should_receive(:new).with(line1).and_return(record)
      logfile.records_matching(prefix).should eq([record])
    end
  end
end
