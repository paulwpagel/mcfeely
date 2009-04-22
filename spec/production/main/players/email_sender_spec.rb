require File.dirname(__FILE__) + '/../../spec_helper'
require "players/email_sender"

describe EmailSender do
  before(:each) do
    @email_sender, @scene, @production = create_player(EmailSender, 
                                                :scene => {}, 
                                                :production => {})
  end
  
  it "should have a button_pressed" do
    @email_sender.button_pressed(nil)
  end
end