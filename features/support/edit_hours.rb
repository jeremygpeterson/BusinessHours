# make private methods public
class BusinessHours
  public :schedule, :closed?, :hours
end


def translate_date(date)
  name = {"Sunday" => :sun, "Monday" => :mon, "Tuesday" => :tue ,"Wednesday" => :wed, "Thursday" => :thur, "Friday" => :fri, "Saturday" => :sat}
  return name[date]||date
end

# Convert String to array of strings that can be evaled
def process_strings(string)
  string.split(", ").map do |val|
    trans = translate_date(val)
    (trans.is_a? Symbol) ? ":#{trans}" : "'#{trans}'"
  end
end