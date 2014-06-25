require_relative'settings_menu'

class LeadsSettings
  include PageObject
  include SettingsMenu

  link(:goto_lead_statuses, :text => 'Lead Statuses')

  #TODO-opinion FInding those buttons should be improved!! (what if there were 1000 Edits ?). Try using the Leadstatus name to find the button
  #button(:edit_first_lead_status_name, :text => 'Edit', :index => 1) #This does not work
  # This button ate me some time. Watir looks for the first element. The first button exists, but is not visible.
  button(:edit_lead_status_name, :class => 'btn btn-mini edit', :index => 1)
  button(:save_lead_status_name, :class => 'btn btn-primary save', :index => 2)

  #TODO-opinion Should methods be splitted? Lots of actions are done only when setting leadstatus name, not usable anywhere else.
  def change_lead_status_fromto(old_leadstatus_name, new_leadstatus_name)
    goto_lead_statuses
    wait_until{ edit_lead_status_name_element.visible? }
    sleep 2 # Sleeps are bad, I know. I have to wait until the hidden element loaded.
            #Otherwise the next Edit is clicked. I may explain what I mean, give me a chance :)
    edit_lead_status_name

    #TODO-sonia Get to know how to make an element taking a variable name
    wait_until{ @browser.text_field(:value => old_leadstatus_name, :id => 'name').visible? }
    @browser.text_field(:value => old_leadstatus_name, :id => 'name').set(new_leadstatus_name)

    # itrate indexes and just click the one that is visible (??) Otherwise the index needs to be hardcoded, what is so so so not ok that.....aaawwwhhh
    save_lead_status_name
  end

  def wait_for_setting
    wait_until{ settings_title_element.visible? }
  end
end