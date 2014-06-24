Given(/^I am on the Base logging page$/) do
  visit_page(LoginPage)
  @current_page.wait_for_loading_elements
end

When(/^I Log into the Web version of Base$/) do
  on_page(LoginPage).log_in
end

And(/^Create a new Lead$/) do
  #TODO-Q Is is better to merge those two steps? Each time to add a Lead I have to go to the Leads page. But How I may ensure page is loaded ?
  on_page(LeadsPage).goto_leads
  @current_page.wait_for_loading_elements
  @current_page.skip_intro
  @current_page.add_random_lead
end

Then(/^Lead status is "(.*?)"$/) do |lead_status|
  #TODO-sonia Replace this when you get to know the good wait. Include in the LeadsPage
  sleep 6
  fail 'Lead status is not '+lead_status.to_s unless on_page(LeadsPage).lead_status_on_page.include? lead_status.to_s
  #This was the first version. I had some problem with nested element in PageObject get working
  #@browser.div(:class => 'status').span(:class => 'lead-status').text.should include lead_status
end

When(/^I change the name of the "(.*?)" status to "(.*?)"$/) do |arg1, arg2|
  $lead_status_changed_flag = 0
  on_page(LeadsPage).open_settings
  on_page(LeadsSettings).wait_for_setting
  on_page(LeadsSettings).goto_leads_settings
  on_page(LeadsSettings).change_lead_status_fromto(arg1, arg2)
  $lead_status_changed_flag = 1
  #puts @browser.text_field(:value => 'New2', :id => 'name').visible?
  #@browser.text_field(:value => 'New2', :id => 'name').set('ala ma kooota ooota oota')

  #@browser.text_field(:value => 'New2', :id => 'name').set('New2')

  #needed for cleaning. Is it OK or better is to put the step with explicit names. Would not it be too much do to ..?
  $name_changed_from = arg1
  $name_changed_to = arg2
end

Then(/^Created lead status name is changed$/) do
  on_page(LeadsPage).goto_leads
  @current_page.wait_for_loading_elements
  @current_page.skip_intro
  puts 'intro skipped'
  @current_page.open_lead
  puts 'below name changed to:'
  puts $name_changed_to
  fail 'Gosh, apparently the lead status name is not the one you changed to.... 'unless on_page(LeadsPage).lead_status_on_page.include? $name_changed_to
  #TODO-opinion If the test fails as now (status have been changed but with no result), cleaning is needed but will not be performed since test will fail above
  $lead_status_changed_flag = 1
end

And(/^The clean I make$/) do
  puts '#######################################===---- DONE----====############################'
  puts 'name changed to:'
  puts $name_changed_to
  #if $lead_status_changed_flag == 1
  #  on_page(LeadsPage).open_settings
  #  on_page(LeadsSettings).wait_for_setting
  #  on_page(LeadsSettings).goto_leads_settings
  #  on_page(LeadsSettings).change_lead_status_fromto($name_changed_to, $name_changed_from)
  #  $lead_status_changed_flag = 0
  #end
end