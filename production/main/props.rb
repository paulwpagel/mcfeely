main {
  title :text => "McFeely Mailer"
  __install "main/smtp_settings_props.rb"
  
  form {
    row {
      header :text => "Tokens"
    }
    row {
      label :text => "To use a token named \"first\" in the body, type \"token_first\" and it will be replaced by the appropriate value", :top_padding => 7
    }
    row {
      label :text => "Tokens and emails are comma separated"
      button :id => "add_token", :players => "add_token", :text => "Add Token", :width => 150
    }
    token_group :id => "token_group"
  }
  
  form {
    row {
      header :text => "Email"
    }
    row {
      email_form_label :text => "To:"
      text_area :id => "to_addresses", :width => "300"
    }
    row {
      email_form_label :text => "Subject:"
      text_box :id => "subject", :width => "600"
    }
    row {
      email_form_label :text => "Body:"
      text_area :id => "body", :width => "600", :height => "200"
    }
    row {
      button :id => "email_sender", :players => "email_sender", :text => "Send Emails", :width => 150
    }
  }
}