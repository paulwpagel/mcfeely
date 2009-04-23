require "mailer"

module EmailSender
  prop_reader :smtp_address, :smtp_port, :smtp_domain, :smtp_user_name, :smtp_password, :body, :to_addresses, :subject, :token_group
  
  def button_pressed(event)
    mailer.send_mail(:body => body.text, :recipients => to_addresses.text, :subject => subject.text, :tokens => token_hash)
  end
  
  private
  
  def mailer
    return Mailer.new({:address => smtp_address.text, :port => smtp_port.text.to_i, :domain => smtp_domain.text,
                                :user_name => smtp_user_name.text, :password => smtp_password.text})
  end
  
  def token_hash
    hash = {}
    token_group.children.each do |token|
      hash[token.children[0].text] = token.children[1].text.split(",").map{|value|value.strip}
    end
    return hash
  end
end