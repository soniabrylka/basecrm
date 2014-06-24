module SettingsMenu
  include PageObject

  h1(:settings_title, :text => 'Settings')
  #div(:settings_title, :class => /title-bar-inner/)

  link(:goto_leads_settings, :href => '/settings/leads')


end