require 'appdirect_log_record'

class AppdirectLogfile
  def initialize(io)
    @io = io
  end

  def records
    @io.lines.map do |line|
      AppdirectLogRecord.new(line)
    end
  end
end
