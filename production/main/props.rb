main {
  title :text => "McFeely Mailer"
  __install "main/smtp_settings_props.rb"
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
      text_area :id => "body", :width => "600", :height => "350"
    }
    row {
      button :id => "email_sender", :players => "email_sender", :text => "Send Emails", :width => 150
    }
  }
}