require "mailer"

module EmailSender
  prop_reader :smtp_address, :smtp_port, :smtp_domain, :smtp_user_name, :smtp_password, :body, :to_addresses, :subject
  
  def button_pressed(event)
    mailer = Mailer.new({:address => smtp_address.text, :port => smtp_port.text.to_i, :domain => smtp_domain.text, :user_name => smtp_user_name.text, :password => smtp_password.text})
    mailer.send_mail(:body => body.text, :recipients => to_addresses.text, :subject => subject.text)
  end
end