#hours.update :fri, "10:00 AM", "5:00 PM"
Given /^a business that opens at "([^\"]*)" and closes at "([^\"]*)"$/ do |open, close|
  hours = BusinessHours.new("9:00 AM", "3:00 PM")
end

Given /^Buisness Hours are set$/ do
  pending # express the regexp above with the code you wish you had
end

#hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"
When /^I Update "([^\"]*)" to open at "([^\"]*)" and close at "([^\"]*)"$/ do |day, open, close|
  hours.update :fri, open, close
end

#hours.closed :sun, :wed, "Dec 25, 2010"
When /^I Close on \[(.*)\]$/ do |days|
  hours.closed days
end


