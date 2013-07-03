require 'yajl'

class CcngLogRecord
  attr_reader :line

  def initialize(line)
    @line = line
    pos = line.index('{')
    @record = Yajl::Parser.parse(line[pos..-1])
  end

  def timestamp
    @timestamp ||= Time.at(@record.fetch('timestamp'))
  end

  def request_guid
    @record.fetch('data').fetch('request_guid')
  end
end
