require 'spec_helper'

require 'correlator'

describe Correlator do
  subject(:correlator) do
    described_class.new(
      prefix,
      fake_ccng_logfile,
      fake_ad_logfile,
    )
  end
  let(:fake_cc_record) { double(timestamp: 1, request_guid: 'not-matching') }
  let(:fake_cc_record_matching) { double(timestamp: 100, request_guid: 'request_guid_prefix_1') }
  let(:fake_cc_record_matching2) { double(timestamp: 119, request_guid: 'request_guid_prefix_2') }
  let(:fake_cc_record_late) { double(timestamp: 200, request_guid: 'wont match') }

  let(:fake_ad_record) { double(timestamp: 2) }
  let(:fake_ad_record_matching) { double(timestamp: 101) }
  let(:fake_ad_record_late) { double(timestamp: 200) }

  let(:prefix) { 'request_guid_prefix' }
  let(:fake_ccng_logfile) do
    double(
      'ccng logfile',
      records: [
        fake_cc_record,
        fake_cc_record_matching,
        fake_cc_record_matching2,
        fake_cc_record_late,
      ]
    )
  end
  let(:fake_ad_logfile) do
    double(
      'appdirect logfile',
      records: [
        fake_ad_record,
        fake_ad_record_matching,
        fake_ad_record_late,
      ]
    )
  end
  describe '#matching' do
    it 'returns all ccng log records matching the request guid prefix' do
      correlator.matching.should eq(
        [
          fake_cc_record_matching,
          fake_cc_record_matching2,
        ]
      )
    end
  end

  describe '#related' do
    it 'returns appdirect log records in the time range of matcing records in ccng log file' do
        correlator.related.should eq([fake_ad_record_matching])
    end

    context 'when no records in cc matches' do
      let(:prefix) { 'never gonna match' }
      it 'returns empty array' do
        correlator.related.should eq([])
      end
    end
  end
end
