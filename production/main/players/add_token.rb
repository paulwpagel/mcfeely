module AddToken
  prop_reader :token_group
  
  def button_pressed(event)
    token_group.build do
      __install("main/token_props.rb")
    end
  end
end