resource "opsgenie_user" "neeraj" {
  username  = "neerajnirala1999@gmail.com"
  full_name = "Neeraj Kumar"
  role      = "User"
  locale    = "en_US"
  timezone  = "Asia/Kolkata"
  tags = ["sre", "opsgenie", "devops"]
  skype_username = "Neerajskype"
  user_address {
      country = "India"
      state = "Bihar"
      city = "patna"
      line = "Line"
      zipcode = "998877"
  }
  user_details = {
    key1 = "val1,val2"
    key2 = "val3,val4"
  }
}

resource "opsgenie_user_contact" "swapnil_sms" {
  username = "${opsgenie_user.swapnil.username}"
  to       = "91-7477222429"
  method   = "sms"
}

resource "opsgenie_user_contact" "swapnil_mail" {
  username = "${opsgenie_user.swapnil.username}"
  to       = "swapnil.kanere@gmail.com"
  method   = "email"
}

resource "opsgenie_user_contact" "swapnil_voice" {
  username = "${opsgenie_user.swapnil.username}"
  to       = "91-7477222429"
  method   = "voice"
}
