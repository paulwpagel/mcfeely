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

    @mailer.send_mail("content", "")
  end
  
  it "should send the mail" do
    @smtp.should_receive(:send_message).with("content", "user_name", ["em@il.com"])
    
    @mailer.send_mail("content", "em@il.com")
  end
  
  it "should send the mail to multiple addresses" do
    @smtp.should_receive(:send_message).with("content", "user_name", ["one@place.com", "two@place.com"])
    
    @mailer.send_mail("content", "one@place.com, two@place.com")
  end
end
# describe "real" do
#   it "should work" do
#     @mailer = Mailer.new({:address => "smtp.emailsrvr.com", :port => 587, :domain => "softwarecraftsmanship.com", :user_name => "jobs@softwarecraftsmanship.com", :password => "someonesgottadoit"})
#     @mailer.send_mail("some content", ["emeyer@8thlight.com"])
#   end
# end