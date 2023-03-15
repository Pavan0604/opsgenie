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

resource "opsgenie_escalation" "splunk_team_escalation" {
  name = "splunk_team_escalation"

  rules {
    condition   = "if-not-acked"
    notify_type = "default"
    delay       = 1

    recipient {
      type = "team"
      id   = "${opsgenie_team.splunk_escalation.id}"
      }
    }
}
