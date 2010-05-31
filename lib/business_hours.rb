require "time"
class BusinessHours
  DAYS = {:sun => 0, :mon => 1, :tue => 2, :wed => 3, :thur => 4, :fri => 5, :sat => 6}

  def initialize(open, close)
    @week = Array.new(7){day(open, close)}
  end

  def update(date, open, close)
    @week[DAYS[date]] = day(open, close) if (date.is_a? Symbol)
  end


  private
  def get(date)
    return @week[DAYS[date]] if (date.is_a? Symbol)
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
