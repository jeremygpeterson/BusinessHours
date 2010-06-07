Feature: Calculate Deadline from Business Hours
  In order to calculate deadline from business hours
  As a customer
  I want to calculate deadline

  Background: Business Hours are Defined
    Given a business that opens at "9:00 AM" and closes at "3:00 PM"
    When I Update "Friday" to open at "10:00 AM" and close at "5:00 PM"
    And I Update "Dec 24, 2010" to open at "8:00 AM" and close at "1:00 PM"
    And I Close on ":sun, :wed, '12/25/2010'"

  Scenario Outline: Calculate deadline
    Given Business Hours are set
    When I calculate deadline "<time>" from "<start>"
    Then the deadline will be "<result>"

    Examples:
      | time     | start                | result                   |
      | 2*60*60  | Jun 7, 2010 9:10 AM  | Mon Jun 07 11:10:00 2010 |
      | 15*60    | Jun 8, 2010 2:48 PM  | Thu Jun 10 09:03:00 2010 |
      | 7*60*60  | Dec 24, 2010 6:45 AM | Mon Dec 27 11:00:00 2010 |

