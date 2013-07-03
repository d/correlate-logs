require 'date'

class AppdirectLogRecord
  attr_reader :line
  def initialize(line)
    @line = line
  end

  def timestamp
    @timestamp ||=
      begin
        time_in_bracket = line[/\[(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d[^\]]*)\]/, 1]
        format = '%Y-%m-%d %H:%M:%S.%N'
        d = DateTime.strptime(time_in_bracket, format).to_time.utc
      end
  end
end
