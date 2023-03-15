#terraform for opsgenie
terraform {
  required_providers {
    opsgenie = {
      source  = "opsgenie/opsgenie"
    }
  }
}

resource "opsgenie_user" "swapnil" {
  username  = "swapnilkanere@gmail.com"
  full_name = "Swapnil"
  role      = "User"
  locale    = "en_US"
  timezone  = "America/New_York"
  tags = ["sre", "opsgenie"]
  skype_username = "skypename"
  user_address {
      country = "India"
      state = "Karnataka"
      city = "Bangalore"
      line = "line"
      zipcode = "998877"
  }
  user_details = {
    key1 = "val1,val2"
    key2 = "val3,val4"
  }
}
