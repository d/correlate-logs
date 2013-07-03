require 'ccng_log_record'

class CcngLogfile
  def initialize(io)
    @io = io
  end

  def records
    _records(@io.lines)
  end

  def records_matching(prefix)
    _records(@io.lines.select {|line| line.include?(prefix)})
  end

  private
  def _records(lines)
    lines.map(&CcngLogRecord.method(:new))
  end
end
