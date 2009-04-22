require File.dirname(__FILE__) + '/../../spec_helper'
require "players/email_sender"

describe EmailSender do
  before(:each) do
    @email_sender, @scene, @production = create_player(EmailSender, 
                                                :scene => {}, 
                                                :production => {})
    @event = nil
    @mailer = mock("mailer", :send_mail => nil)
    Mailer.stub!(:new).and_return(@mailer)
  end
  
  it "should create a mailer with an address" do
    @email_sender.smtp_address.stub!(:text).and_return("some address")
    
    Mailer.should_receive(:new).with(hash_including({:address => "some address"}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should create a mailer with a port" do
    @email_sender.smtp_port.stub!(:text).and_return("1234")
    
    Mailer.should_receive(:new).with(hash_including({:port => 1234}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should create the mailer with a domain" do
    @email_sender.smtp_domain.stub!(:text).and_return("some domain")
    
    Mailer.should_receive(:new).with(hash_including({:domain => "some domain"}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should create a mailer with a user name" do
    @email_sender.smtp_user_name.stub!(:text).and_return("Slim Shady")
    
    Mailer.should_receive(:new).with(hash_including({:user_name => "Slim Shady"}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should create a mailer with a password" do
    @email_sender.smtp_password.stub!(:text).and_return("imasecret")
    
    Mailer.should_receive(:new).with(hash_including({:password => "imasecret"}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should send mail" do
    @email_sender.body.stub!(:text).and_return("Good day, sir! I am a Nigerian prince with money to give you.")
    @email_sender.to_addresses.stub!(:text).and_return("eric@meyer.com, colin@jones.com")
    
    @mailer.should_receive(:send_mail).with("Good day, sir! I am a Nigerian prince with money to give you.", "eric@meyer.com, colin@jones.com")
    
    @email_sender.button_pressed(@event)
  end
end