require "net/smtp"
class Mailer
  def initialize(options)
    @address = options[:address]
    @port = options[:port]
    @domain = options[:domain]
    @user_name = options[:user_name]
    @password = options[:password]
  end
  
  def send_mail(options)
    Net::SMTP.start(@address, @port, @domain, @user_name, @password, :login) do |smtp|
      message =<<END  
To: #{options[:recipients]}
Subject: #{options[:subject]}
#{options[:body]}
END
      smtp.send_message(message, @user_name, options[:recipients].split(",").map{|r| r.strip})
    end
  end
end