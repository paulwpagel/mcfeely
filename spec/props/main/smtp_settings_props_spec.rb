require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "smtp settings props" do
  
  uses_scene :main
  
  it "should have an input field to enter in email addresses" do
    prop = scene.find('smtp_address')
    prop.should_not be_nil
  end
  
  it "should have an input for the port" do
    prop = scene.find('smtp_port')
    prop.should_not be_nil
  end
  
  it "should have an input for the domain" do
    prop = scene.find('smtp_domain')
    prop.should_not be_nil
  end
  
  it "should have an input for the user name" do
    prop = scene.find('smtp_user_name')
    prop.should_not be_nil
  end
  
  it "should have an input for the password" do
    prop = scene.find('smtp_password')
    prop.should_not be_nil
  end
end
