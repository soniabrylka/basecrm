require_relative'top_menu'
require_relative '../test_data'

  class LeadsPage
  include PageObject
  include TopMenu
  include TestData

  link(:add_new_lead, :href => '/leads/new')

  text_field(:lead_first_name, :id => 'lead-first-name')
  text_field(:lead_last_name, :id => 'lead-last-name')

  button(:save, :text => 'Save')

  span(:lead_status_on_page){ div_element(:class => 'status').span_element }

  #TODO-opinion Not adding the default data - a new lead will be added each time, instead of adding one and remove after test
  def add_random_lead
    self.add_new_lead
    self.lead_first_name = $new_lead_name
    self.lead_last_name = $new_lead_surname
    self.save
  end

  def skip_intro
    #TODO-Q How to wait for popup I never know will show ? If i make wait for and the popup will not appear...?
    sleep 5
    if
      @browser.text.include? 'Introducing Lead and Deal Scoring'
      popup = @browser.div(:id => 'reports-loader', :class => 'modal')
      popup.div(:class => 'modal-body').a(:text => 'Skip').click
      sleep 3 #TODO-opinion This is to wait for popup to disappear. Without this the next click is done too early and I get the error. But also this helps the LeadsPage to load fully
      #Selenium::WebDriver::Error::UnknownError: unknown error:
      # Element is not clickable at point (101, 115).
      # Other element would receive the click: <div id="reports-backdrop" style="opacity: 0.31274270810161253;"></div>
    else
      wait_until{ add_new_lead_element.visible? }
    end
  end

  def open_lead
    #TODO-sonia The same as in lead_settings page: Get to know how to make an element taking a variable name
    @browser.link(:class => 'lead-name', :text => $new_lead_name+' '+$new_lead_surname).click
    sleep 4
  end

  def wait_for_add_lead
    wait_until{ add_new_lead_element.visible? }
  end

  def wait_for_leadstatus
    wait_until{ lead_status_on_page_element.visible? }
  end

end