require 'ccng_log_record'

class CcngLogfile
  def initialize(io)
    @io = io
  end

  def records
    @io.lines.map do |line|
      CcngLogRecord.new(line)
    end
  end
end
