require File.dirname(__FILE__) + '/../spec_helper'
require "mailer"

describe Mailer do
  before(:each) do
    @smtp = mock("smtp", :send_message => nil)
    Net::SMTP.stub!(:start).and_yield(@smtp)
    @mailer = Mailer.new({:address => "smtp.server.com", :port => 123, :domain => "www.server.com", :user_name => "user_name", :password => "password"})
  end

  it "create a start the smtp object when sending the mail" do
    Net::SMTP.should_receive(:start).with("smtp.server.com", 123, "www.server.com", "user_name", "password", :login).and_yield(@smtp)

    @mailer.send_mail({:recipients => ""})
  end
  
  it "should send the mail to one address" do
    @smtp.should_receive(:send_message).with(anything(), "user_name", ["em@il.com"])
    
    @mailer.send_mail({:body => "content", :recipients => "em@il.com", :subject => "subject"})
  end
  
  it "should send the mail to multiple addresses" do
    @smtp.should_receive(:send_message).with(anything(), "user_name", ["one@place.com", "two@place.com"])
    
    @mailer.send_mail({:body => "content", :recipients => "one@place.com, two@place.com", :subject => "subject"})
  end
  
  it "should build up the message for sending" do
    message = <<END
To: em@il.com
Subject: Some Subject
Body
END
    @smtp.should_receive(:send_message).with(message, anything(), anything())
    
    @mailer.send_mail({:body => "Body", :recipients => "em@il.com", :subject => "Some Subject"})
  end
end


# describe "real" do
#   it "should work" do
#     @mailer = Mailer.new({:address => "smtp.emailsrvr.com", :port => 587, :domain => "softwarecraftsmanship.com", :user_name => "jobs@softwarecraftsmanship.com", :password => "someonesgottadoit"})
#     
#     message_string =<<EOF
# To: emeyer@8thlight.com
# Subject: This is a real test
# Here is the body text itself...
# EOF
#     
#     @mailer.send_mail(message_string, "emeyer@8thlight.com")
#   end
# end