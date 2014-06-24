require_relative'top_menu'

class LoginPage
  include PageObject
  include TopMenu

  #TODO-Q How I may protect the logging data? Should I ?
  DEFAULT_DATA = {
      'user_email' => 'niedorzecznyadres@gmail.com',
      'password' => 'getbase01%'
  }

  page_url('https://core.futuresimple.com/sales/users/login')

  text_field(:user_email, :id => 'user_email')
  text_field(:password, :id => 'user_password')

  button(:submitlogin, :text => 'Login')

  def log_in(data = {})
    data = DEFAULT_DATA.merge(data)
    self.user_email = data['user_email']
    self.password = data['password']
    submitlogin
  end

  def wait_for_loading_elements
    wait_until{ user_email_element.visible? && user_email_element.visible?}
  end

end