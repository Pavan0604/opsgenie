file "/tmp/timer.sh" do
  content <<~SCRIPT
    #!/bin/bash

    # Define the threshold in seconds (1 hour = 3600 seconds)
    THRESHOLD=3600

    # Get the full command including the path to the remote-dev-server.sh using ps and grep
    COMMAND_INFO=$(ps -ef | grep "remote-dev-server.sh" | grep -v grep)

    # Extract the full command line, including the path
    COMMAND_LINE=$(echo "$COMMAND_INFO" | awk -F '/bin/sh ' '{sub(/ run .*/, ""); print $2}')

    # Add "/bin/sh" to the beginning of the command line
    FULL_COMMAND="/bin/sh $COMMAND_LINE"
    # Run the command to get IntelliJ status and store the JSON response in STATUS_JSON
    COMMAND_FOLDER=$(ps -ef |grep remote-dev-server.sh | grep -v grep | awk '{print $NF}')

    STATUS_JSON=$($FULL_COMMAND status $COMMAND_FOLDER)
    # Extract "secondsSinceLastControllerActivity" from the JSON response using jq
    SECONDS_SINCE_LAST_ACTIVITY=$(echo "$STATUS_JSON" | grep -o '"secondsSinceLastControllerActivity": [0-9]*' | awk '{print $2}')
    echo $SECONDS_SINCE_LAST_ACTIVITY

    # Check if the value is numeric
    if [[ "$SECONDS_SINCE_LAST_ACTIVITY" =~ ^[0-9]+$ ]]; then
        # If it's numeric, check if it's greater than the defined threshold
        if [ "$SECONDS_SINCE_LAST_ACTIVITY" -gt "$THRESHOLD" ]; then
            sudo shutdown -h now
        else
            echo "Running for less than an hour"
        fi
    else
        # If the value is not numeric, echo an error message
        echo "Invalid or non-numeric value for secondsSinceLastControllerActivity: $SECONDS_SINCE_LAST_ACTIVITY"
    fi
  SCRIPT
  mode '0755'
end

package 'cronie' do
  action :install
end

cron "run_custom_script" do
  minute '*/5'
  command '/bin/bash /tmp/timer.sh'
  user 'root'
end
