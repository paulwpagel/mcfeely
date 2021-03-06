require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "main props" do
  
  uses_scene :main
  
  it "should have an input field to enter in email addresses" do
    prop = scene.find('to_addresses')
    prop.should_not be_nil
  end
  
  it "should have an input for the subject" do
    scene.find("subject").should_not be_nil
  end
  
  it "should have an input for the body" do
    scene.find("body").should_not be_nil
  end
  
  it "should have a way to send the email" do
    prop = scene.find("email_sender")
    prop.players.should include("email_sender")
    prop.name.should == "button"
  end
  
  it "should have a way to add another token" do
    prop = scene.find("add_token")
    prop.players.should include("add_token")
    prop.name.should == "button"
  end
  
  it "should group the tokens together" do
    scene.find("token_group").should_not be_nil
  end
end
