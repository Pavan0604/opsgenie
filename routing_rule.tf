resource "opsgenie_team" "sre_team" {
  name        = "example team of sre"
  description = "This team deals with all the sre things"
}



resource "opsgenie_team_routing_rule" "ingestion_delivery_test" {
  name     = "Ingestion Delivery Routing Rule"
  team_id  = "${opsgenie_team.splunk_escalation.id}"
  order    = 0
  timezone = "Asia/Kolkata"
  criteria {
    type = "match-all-conditions"
    conditions {
      field          = "tags"
      operation      = "contains"
      expected_value = "index:notificationbackend"
      not            = false
    }
  }
  notify {
    type = "none"
  }
}

resource "opsgenie_team_routing_rule" "ingestion_delivery_test" {
  name     = "Storage and Processing Routing Rule"
  team_id  = "${opsgenie_team.splunk_escalation.id}"
  order    = 1
  timezone = "Asia/Kolkata"
  criteria {
    type = "match-all-conditions"
    conditions {
      field          = "tags"
      operation      = "contains"
      expected_value = "index:logprocessor"
      not            = false
    }
    conditions {
      field          = "tags"
      operation      = "contains"
      expected_value = "index:eventstore"
      not            = false
    }
  }
  notify {
    type = "none"
  }
}
