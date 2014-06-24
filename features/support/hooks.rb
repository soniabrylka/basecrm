require 'watir-webdriver'

TIMEOUT = 300

Before do
  @client = Selenium::WebDriver::Remote::Http::Default.new
  @client.timeout = TIMEOUT # seconds – default is 60
  #@browser = Watir::Browser.new :firefox, :http_client => @client
  @browser = Watir::Browser.new :chrome, :http_client => @client
end

After do
  puts 'cleaning cleaning cleaning '

  if $lead_status_changed_flag == 1
    on_page(LeadsPage).open_settings
    on_page(LeadsSettings).wait_for_setting
    on_page(LeadsSettings).goto_leads_settings
    on_page(LeadsSettings).change_lead_status_fromto($name_changed_to, $name_changed_from)
    $lead_status_changed_flag = 0
  end
  #@browser.close
end