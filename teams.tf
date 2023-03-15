resource "opsgenie_team" "splunk_escalation" {
  name        = "Splunk_escalation"
  description = "This team deals with all the splunk things"

  member {
    id   = "${opsgenie_user.neeraj.id}"
    role = "admin"
  }

  member {
    id   = "${opsgenie_user.swapnil.id}"
    role = "user"
  }
}

