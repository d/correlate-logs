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
  end
end
