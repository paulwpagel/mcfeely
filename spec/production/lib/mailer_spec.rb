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
    
    @mailer.send_mail({:body => "content", :recipients => "em@il.com", :subject => "subject", :tokens => {}})
  end
  
  it "should send one mail per recipient" do
    @smtp.should_receive(:send_message).with(anything(), anything(), ["one@place.com"])
    @smtp.should_receive(:send_message).with(anything(), anything(), ["two@place.com"])
    
    @mailer.send_mail({:body => nil, :recipients => "one@place.com, two@place.com", :subject => nil, :tokens => {}})
  end
  
  it "should build up the message for sending" do
    message = <<END
To: em@il.com
Subject: Some Subject
Body
END
    @smtp.should_receive(:send_message).with(message, anything(), anything())
    
    @mailer.send_mail({:body => "Body", :recipients => "em@il.com", :subject => "Some Subject", :tokens => {}})
  end
  
  it "should replace one token" do
    new_body = @mailer.replace_tokens({"name" => ["value"]}, "some token_name text token_name again", 0)
    new_body.should == "some value text value again"
  end

  it "should replace two tokens" do
    new_body = @mailer.replace_tokens({"first" => ["value one", "value two"], "other" => ["different one", "different two"]},
                                                                                      "some token_first token_other token_first again", 1)
    new_body.should == "some value two different two value two again"
  end
  
  it "should send the replaced body" do
    message = <<END
To: em@il.com
Subject: Some Subject
Body value
END
    @smtp.should_receive(:send_message).with(message, anything(), anything())

    @mailer.send_mail({:body => "Body token_name", :recipients => "em@il.com", :subject => "Some Subject", :tokens => {"name" => ["value"]}})
  end
end