Feature: New lead status is new and changes when lead status name changes

  As the one who wants working at Base
  I want to proceed a lead according to the exercise
  So I may show I can write this automated test :)

Background:
  Given I am on the Base logging page

Scenario:
  When I Log into the Web version of Base
  And Create a new Lead
  Then Lead status is "New"
  When I change the name of the "New" status to "Different_name"
  Then Created lead status name is changed