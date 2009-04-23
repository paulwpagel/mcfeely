require File.dirname(__FILE__) + '/../../spec_helper'
require "players/add_token"

describe AddToken do
  before(:each) do
    @add_token, @scene, @production = create_player(AddToken, 
                                                :scene => {}, 
                                                :production => {})
    @event = nil
  end
  
  it "should add a token on the scene" do
    @add_token.token_group.should_receive(:build)
     
    @add_token.button_pressed(@event)
  end
end