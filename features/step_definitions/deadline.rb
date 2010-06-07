When /^I calculate deadline "([^\"]*)" from "([^\"]*)"$/ do |time, start|
  @result = @hours.calculate_deadline(eval(time), start)
end

Then /^the deadline will be "([^\"]*)"$/ do |result|
  @result.should == Time.parse(result)
end
