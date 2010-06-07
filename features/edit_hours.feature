Feature: Edit Business Hours
  In order to track business hours
  As an owner
  I want to edit daily hours and exceptions

  Background: Business Hours are Defined
    Given a business that opens at "9:00 AM" and closes at "3:00 PM"

  Scenario Outline: Update hours by day of week or date
    Given Business Hours are set
    When I Update "<day>" to open at "<open>" and close at "<close>"
    Then the day/date "<day>" will open at "<open>" and closes at "<close>"

    Examples:
      | day          | open     | close    |
      | Friday       | 10:00 AM |  5:00 PM |
      | Tuesday      |  7:00 AM |  3:45 PM |
      | Dec 25, 2010 | 10:00 AM |  5:00 PM |
      | Dec 26, 2010 |  9:00 AM | 11:00 AM |

  Scenario: Update hours to closed
    Given Business Hours are set
    When I Close on ":sun, :wed, '12/25/2010'"
    Then ":sun, :wed, '12/25/2010'" days will be closed
