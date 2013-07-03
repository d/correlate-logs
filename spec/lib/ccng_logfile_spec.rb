require 'spec_helper'
require 'ccng_logfile'

describe CcngLogfile do
  subject(:logfile) { described_class.new(io) }
  let(:line1) { double('line 1') }
  let(:line2) { double('line 2') }
  let(:io) { double('file', lines: [line1]) }

  describe '#records' do
    it 'parses the lines and return log records' do
      record = double('log record')
      CcngLogRecord.stub(new: record)
      logfile.records.should == [record]
    end
  end
end
