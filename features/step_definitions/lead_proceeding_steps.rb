Given(/^I am on the Base logging page$/) do
  visit_page(LoginPage)
  @current_page.wait_for_loading_elements
end

When(/^I Log into the Web version of Base$/) do
  on_page(LoginPage).log_in
end

And(/^Create a new Lead$/) do
  on_page(LeadsPage).goto_leads
  @current_page.skip_intro #This is needed since while using Watir, the SCORE intro is shown
  @current_page.wait_for_add_lead
  @current_page.add_random_lead
end

Then(/^Lead status is "(.*?)"$/) do |lead_status|
  on_page(LeadsPage).wait_for_leadstatus
  fail 'Lead status is not '+lead_status.to_s unless on_page(LeadsPage).lead_status_on_page.include? lead_status.to_s
end

When(/^I change the name of the "(.*?)" status to "(.*?)"$/) do |old_leadstatus_name, new_leadstatus_name|
  on_page(LeadsPage).open_settings
  on_page(LeadsSettings).wait_for_setting
  on_page(LeadsSettings).goto_leads_settings
  on_page(LeadsSettings).change_lead_status_fromto(old_leadstatus_name, new_leadstatus_name)
  $lead_status_changed_flag = 1 #flag changed not in the method, cause it depends on whether change is to or from New

  # variables used instead of explicit names, since now it is easier to maintain (does not require maintain)
  # ??---> is it better to put both statuses to the test_data.rb, so that they may be used everywhere if needed?
  $name_changed_from = old_leadstatus_name
  $name_changed_to = new_leadstatus_name
end

#TODO-Q Is it a good idea make this step more a wildcard? (/^"(.*?)" leadstatus is changed from "(.*?)" to "(.*?)"$/)  ?
Then(/^Created lead status name is changed$/) do
  on_page(LeadsPage).goto_leads
  @current_page.skip_intro
  # When there is no intro (second click to Lead) then there is no sleep. It makes sometimes the LeadsPage is not fully loaded.
  #TODO-Q How to ensure the page is loaded without a sleep? What check do ou recommend? (sonia, consider filtering! You only search for lead, no need to wait for all)
  sleep 4
  @current_page.open_lead

  begin
    fail unless on_page(LeadsPage).lead_status_on_page.include? $name_changed_to
  rescue => e
    puts e
    puts 'Gosh, apparently the lead status name is not the one you changed to.... '
    # How to make cuke cleans - how to invoke 'After' from hooks ? I do not like below cleaning.
    on_page(LeadsPage).open_settings
    on_page(LeadsSettings).wait_for_setting
    on_page(LeadsSettings).goto_leads_settings
    on_page(LeadsSettings).change_lead_status_fromto($name_changed_to, $name_changed_from)
    $leadstatus_cleaning_required = 0
  end
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