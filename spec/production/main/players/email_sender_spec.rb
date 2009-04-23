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
    @email_sender.token_group.stub!(:children).and_return([])
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
    @email_sender.to_addresses.stub!(:text).and_return("eric@meyer.com, colin@jones.com")
    @email_sender.body.stub!(:text).and_return("some body")
    @email_sender.subject.stub!(:text).and_return("some subject")
    
    @mailer.should_receive(:send_mail).with(hash_including({:recipients => "eric@meyer.com, colin@jones.com", :subject => "some subject", :body => "some body"}))
    
    @email_sender.button_pressed(@event)
  end
  
  it "should convert one token" do
    @email_sender.body.stub!(:text).and_return("some body with %token%")
    tokens = [token("name", "value")]
    @email_sender.token_group.stub!(:children).and_return(tokens)
    
    @mailer.should_receive(:send_mail).with(hash_including({:tokens => {"name" => ["value"]}}))
    
    @email_sender.button_pressed(@event)
  end

  it "should convert a second token" do
    @email_sender.body.stub!(:text).and_return("some body with %token%")
    tokens = [token("name", "value"), token("name two", "value one, value two")]
    @email_sender.token_group.stub!(:children).and_return(tokens)
    
    @mailer.should_receive(:send_mail).with(hash_including({:tokens => {"name" => ["value"], "name two" => ["value one", "value two"]}}))
    
    @email_sender.button_pressed(@event)
  end

  def token(name, values)
    token_name = mock("prop", :text => name)
    token_values = mock("prop", :text => values)
    return mock("token", :children => [token_name, token_values])
  end
end