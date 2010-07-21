#hours.update :fri, "10:00 AM", "5:00 PM"
Given /^a business that opens at "([^\"]*)" and closes at "([^\"]*)"$/ do |open, close|
  @hours = BusinessHours.new("9:00 AM", "3:00 PM")
end

Given /^Business Hours are set$/ do
  @hours.is_a? BusinessHours
end

#hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"
When /^I Update "([^\"]*)" to open at "([^\"]*)" and close at "([^\"]*)"$/ do |day, open, close|
  @hours.update(translate_date(day), open, close)
end

Then /^the day\/date "([^\"]*)" will open at "([^\"]*)" and closes at "([^\"]*)"$/ do |day, open, close|
  @hours.schedule[translate_date(day)].should == [open, close]
end

#hours.closed :sun, :wed, "Dec 25, 2010"
When /^I Close on "([^\"]*)"$/ do |days|
  close_days = process_strings(days).join(', ')
  eval "@hours.closed(#{close_days})"
end

Then /^"([^\"]*)" days will be closed$/ do |days|
  process_strings(days).each do |day|
    hours = eval "@hours.closed?(#{day})"
    hours.should == true
  end
end

