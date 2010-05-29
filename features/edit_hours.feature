Feature: Edit Business Hours
  In order to track business hours
  As an owner
  I want to edit daily hours and exceptions

  Background: Business Hours are Defined
    Given a business that opens at "9:00 AM" and closes at "3:00 PM"

  Scenario: Update hours for a day of the week
    Given Buisness Hours are set
    When I Update "Friday" to open at "10:00 AM" and close at "5:00 PM"

  Scenario: Update hours for a date only
    Given Buisness Hours are set
    When I Update "Dec 25, 2010" to open at "8:00 AM" and close at "1:00 PM"

  Scenario: Update hours to closed
    Given Buisness Hours are set
    When I Close on ["Sunday", "Wednesday", "Dec 25, 2010"]



