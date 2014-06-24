require_relative'top_menu'

  class LeadsPage
  include PageObject
  include TopMenu

  link(:add_new_lead, :href => '/leads/new')
  #link(:skip_intro, :text => 'Skip')

  text_field(:lead_first_name, :id => 'lead-first-name')
  text_field(:lead_last_name, :id => 'lead-last-name')

  button(:save, :text => 'Save')

  #TODO-opinion There is so much of lead status! Variable passed, span class= , name of the element ....how not to get confused ?
  span(:lead_status_on_page){ div_element(:class => 'status').span_element }


  def add_random_lead #TODO-opinion I am not adding the default data, since I will probably add a new lead each time, not only one lead hundred of times
    generate_random_data
    self.add_new_lead
    self.lead_first_name = $new_lead_name
    self.lead_last_name = $new_lead_surname
    self.save
  end

  def wait_for_loading_elements
    #TODO-sonia Replace this sleep with the solution used in login_page
    #TODO-sonia DRY - Investigate whether you may use any 'general' method that would be fine on every page.
    sleep 8
  end

  def skip_intro #I wish I didn't have to make this workaround, but on Sunday the pretty Score window has been implemented....
    sleep 5
    if @browser.text.include? 'Introducing Lead and Deal Scoring'
      puts 'Intro window is visibleeee, aaaa, get riiiid of thiiiiiiiisss nooowwww!!!!'
      popup = @browser.div(:id => 'reports-loader', :class => 'modal')
      puts popup.div(:class => 'modal-body').a(:text => 'Skip').exists?
      # wait_until{ !skip_intro_element.attribute('disabled') } #This anyway does not work
      # popup.div(:class => 'modal-body').a(:text => 'Skip').when_present.click  #This wait does not work too
      popup.div(:class => 'modal-body').a(:text => 'Skip').click
      sleep 5 #TODO-Q Why the hell without this sleep a "reports-backdrop" is clicked, the next div, althought puts returned true.
    else
      puts 'Great, popup removed !'
    end
  end


  def open_lead#(leadname, leadsurname)
    puts ' below lead name'
    puts $new_lead_name
    puts $new_lead_surname
    @browser.link(:class => 'lead-name', :text => $new_lead_name+' '+$new_lead_surname).click
    sleep 4
  end

  #private

  #TODO-opinion I may replace this with some random data gem, but this is not crucial in this test to have a nice data
  #TODO-opinion I should probably remove generation of data to some test-data-cration
  def generate_random_data
    puts ' generate random data nic nie ma'
    random_string = ('a'..'z').to_a.shuffle[0..3].join
    $new_lead_name = 'name_'+random_string
    $new_lead_surname = 'surname_'+random_string
  end
end