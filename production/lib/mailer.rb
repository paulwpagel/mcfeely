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
      options[:recipients].split(",").map{|r|r.strip}.each_with_index do |recipient, index|
        message =<<END
To: #{recipient}
Subject: #{options[:subject]}
#{replace_tokens(options[:tokens], options[:body], index)}
END
        smtp.send_message(message, @user_name, [recipient])
      end
    end
  end
  
  def replace_tokens(token_hash, body, index)
    new_body = body.to_s
    token_hash.each_pair { |name, values| new_body = new_body.gsub(/token_#{name}/, values[index]) }
    return new_body
  end
    
end