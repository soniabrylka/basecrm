require 'watir-webdriver'

TIMEOUT = 300

Before do
  @client = Selenium::WebDriver::Remote::Http::Default.new
  @client.timeout = TIMEOUT # seconds – default is 60
  #@browser = Watir::Browser.new :firefox, :http_client => @client
  @browser = Watir::Browser.new :chrome, :http_client => @client
end

After do
  if $leadstatus_cleaning_required == 1
    puts 'Cleaning after test performed......'
    on_page(LeadsPage).open_settings
    on_page(LeadsSettings).wait_for_setting
    on_page(LeadsSettings).goto_leads_settings
    on_page(LeadsSettings).change_lead_status_fromto($name_changed_to, $name_changed_from)
    $leadstatus_cleaning_required = 0
  end
  #@browser.close
end