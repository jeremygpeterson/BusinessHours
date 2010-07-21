require "time"
class BusinessHours
  def initialize(open, close)
    @schedule = Schedule.new([open, close])
  end

  def update(date, open, close)
    @schedule[date]= [open, close]
  end

  def closed(*dates)
    dates.each{|date| update(date, "0:00", "0:00")}
  end

  def calculate_deadline(remaining, start_time = Time.now)
    Deadline.new(@schedule, remaining, start_time).calculate
  end

  class Schedule
    DAYS = [:sun, :mon, :tue, :wed, :thur, :fri, :sat]
    def initialize(hours)
      @schedule = {}
      DAYS.each{|day| self[day]= hours}
    end

    def key(date)
      (date.is_a? Symbol) ? date : Time.parse(date.to_s).strftime("%x")
    end

    def []=(date, value)
      @schedule[key(date)] = value
    end

    def [](date)
      @schedule[key(date)] || @schedule[DAYS[Time.parse(date.to_s).wday]]
    end
  end

  class Deadline
    def initialize(schedule, remaining, start_time)
      @schedule, @remaining = schedule, remaining
      @current_time = Time.parse(start_time)
    end

    def calculate
      each_day do
        return @current_time + @remaining if ((@current_time + @remaining) <= @hours.last)
        @remaining -= (@hours.last - @current_time) if ((@current_time <= @hours.last))
      end
    end

    def update_hours
      @hours = @schedule[@current_time].collect {|hour| Time.parse(hour, @current_time)}
      @current_time = @hours.first if(@hours.first && @current_time < @hours.first)# adjust to starting time
    end

    # Iterate Scheduled Business Hours
    def each_day
      loop do
        update_hours
        yield
        @current_time = Time.parse("0:00 AM", @current_time + 24*60*60)# prepare for next day
      end
    end
  end
end