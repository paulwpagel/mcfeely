main {
  email_form {
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
      text_area :id => "body", :width => "600", :height => "550"
    }
    row {
      button :id => "email_sender", :players => "email_sender", :text => "Send Emails", :width => 150
    }
  }
}