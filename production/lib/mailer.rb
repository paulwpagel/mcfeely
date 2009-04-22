require "net/smtp"
class Mailer
  def initialize(options)
    @address = options[:address]
    @port = options[:port]
    @domain = options[:domain]
    @user_name = options[:user_name]
    @password = options[:password]
  end
  
  def send_mail(body, recipients)
    Net::SMTP.start(@address, @port, @domain, @user_name, @password, :login) do |smtp|
      smtp.send_message(body, @user_name, recipients.split(",").map{|r| r.strip})
    end
  end
end