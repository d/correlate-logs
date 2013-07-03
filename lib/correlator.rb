require 'appdirect_logfile'
require 'ccng_logfile'

class Correlator
  def initialize(request_guid_prefix, ccng_logfile, ad_logfile)
    @prefix = request_guid_prefix
    @ccng_logfile = ccng_logfile
    @ad_logfile = ad_logfile
  end

  def matching
    @matching ||= @ccng_logfile.records.select do |r|
      r.request_guid.start_with?(@prefix)
    end
  end

  def related
    @related ||=
    begin
      # wow you can actually locally `return` from a begin-end block
      return [] if matching.empty?

      start_time = matching.first.timestamp
      end_time = matching.last.timestamp
      @ad_logfile.records.select do |r|
        (start_time .. end_time).cover?(r.timestamp)
      end
    end
  end
end
