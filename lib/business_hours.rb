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
    Deadline.new(@schedule, remaining, Time.parse(start_time)).calculate
  end

  class Schedule
    DAYS = [:sun, :mon, :tue, :wed, :thur, :fri, :sat]

    def initialize(hours)
      @schedule = {}
      DAYS.each{|day| self[day]= hours}
    end

    def []=(date, value)
      @schedule[key(date)] = value
    end

    def [](date)
      @schedule[key(date)] || @schedule[DAYS[Time.parse(date.to_s).wday]]
    end

    private
    def key(date)
      (date.is_a? Symbol) ? date : Time.parse(date.to_s).strftime("%x")
    end
  end

  class Deadline
    def initialize(*args)
      @schedule, @remaining, @current_time = *args
    end

    def calculate
      next_day while time_remaining?
      return @current_time + @remaining
    end

    private
    def next_day
      @remaining -= (@hours.last - @current_time)# adjust remaining hours
      @current_time = Time.parse("0:00 AM", @current_time + 24*60*60)# increment to next day
    end

    def time_remaining?
      @hours = @schedule[@current_time].collect {|hour| Time.parse(hour, @current_time)}
      @current_time = (@current_time < @hours.first) ? @hours.first : (@current_time > @hours.last) ? @hours.last : @current_time # force to be inside normal business hours
      (@current_time + @remaining) >= @hours.last
    end
  end
end