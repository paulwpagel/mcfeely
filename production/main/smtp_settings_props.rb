form {
  row {
    header :text => "SMTP Settings"
  }
  row {
    smtp_form_label :text => "Address:"
    text_box :id => "smtp_address", :width => 200
    smtp_form_label :text => "Port:"
    text_box :id => "smtp_port", :width => 200
    smtp_form_label :text => "Domain:"
    text_box :id => "smtp_domain", :width => 200
  }
  row {
    smtp_form_label :text => "User Name:"
    text_box :id => "smtp_user_name", :width => 200
    smtp_form_label :text => "Password:"
    password_box :id => "smtp_password", :width => 200
  }
}