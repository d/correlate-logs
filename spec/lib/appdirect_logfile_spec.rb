require 'spec_helper'

require 'appdirect_logfile'

describe AppdirectLogfile do
  describe '#records' do
    subject(:logfile) do
      described_class.new(io)
    end

    let(:io) { double('file', lines:[line]) }
    let(:line) { double('line') }

    it 'parses the log lines' do
      record = double('log record')
      AppdirectLogRecord.stub(new: record)
      logfile.records.should eq([record])
    end
  end
end
