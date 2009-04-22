form {
  row {
    header :text => "SMTP Settings"
  }
  smtp_form_label :text => "Address:"
  text_box :id => "smtp_address"
  smtp_form_label :text => "Port:"
  text_box :id => "smtp_port"
  smtp_form_label :text => "Domain:"
  text_box :id => "smtp_domain"
  smtp_form_label :text => "User Name:"
  text_box :id => "smtp_user_name"
  smtp_form_label :text => "Password:"
  password_box :id => "smtp_password"
}