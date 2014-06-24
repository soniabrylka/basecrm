module TopMenu
  include PageObject

  #TODO-opinion Should I fill other top menu elements, or add them they are needed ?
  link(:goto_leads, :id => 'nav-leads')
  link(:goto_contacts, :id => 'nav-contacts')
  link(:unfold_config, :href => '#user-dd')

  #TODO-opinion I do not like this way of finding. Is ot ok? Theoreticaly we should do the simplest thing that works.
  #TODO-opinion Elements should be named by actions they make. But then there is a problem with finding a good method name.
  link(:goto_settings, :href => '/settings/profile')

  ul(:config_menu, :class => 'topbar-settings-dropdown dropdown-menu')
  div(:topbar, :id => 'topbar')

  def open_settings
    unfold_config
    goto_settings
  end

end