require "time"
class BusinessHours
  DAYS = [:sun, :mon, :tue, :wed, :thur, :fri, :sat]

  def initialize(open, close)
    @schedule = {}
    DAYS.each{|d| @schedule[d] = day(open, close)}
  end

  def update(date, open, close)
    key = (DAYS.include? date) ? date : Time.parse(date)
    @schedule[key] = day(open, close)
  end


  private
  def get(date)
    key = (DAYS.include? date) ? date : Time.parse(date)
    return @schedule[key]
  end

  def closed(date)

  end

  def closed?(date)
    true
  end
  
  def day(open, close)
    {:open => Time.parse(open), :close => Time.parse(close)}
  end
end
