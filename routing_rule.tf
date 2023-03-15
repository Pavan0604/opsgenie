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
  time_restriction {
    type = "weekday-and-time-of-day"
    restrictions {
      start_day  = "monday"
      start_hour = 8
      start_min  = 0
      end_day    = "tuesday"
      end_hour   = 18
      end_min    = 30
    }
  }
  notify {
    type = "none"
  }
}
