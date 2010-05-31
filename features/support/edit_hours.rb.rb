# make private methods public
class BusinessHours
  public :get, :closed, :closed?, :day
end


def translate_date(date)
  name = {"Sunday" => :sun, "Monday" => :mon, "Tuesday" => :tue ,"Wednesday" => :wed, "Thursday" => :thur, "Friday" => :fri, "Saturday" => :sat}
  return name[date]||Time.parse(date)
end