require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "main props" do
  
  uses_scene :main
  
  it "should have an input field to enter in email addresses" do
    prop = scene.find('to_addresses')
    prop.should_not be_nil
  end
end
