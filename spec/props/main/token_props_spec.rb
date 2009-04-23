require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "main props" do
  
  uses_scene :main
  
  it "should have a field for the token name" do
    scene.find("add_token").button_pressed(nil)
    
    token = scene.find_by_name("token")[0]
    token.children[0].name.should == "text_box"
    token.children[1].name.should == "text_area"
  end
end