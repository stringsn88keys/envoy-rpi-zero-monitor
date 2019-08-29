# Envoy Monitor

Reads the `envoy.local` JSON production data from the monitor API.

# Usage

Put on a server (such as a Raspberry Pi Zero W in my case) that has access to the same wifi network as your Envoy unit.

## Create config
Create a `.config` in the same folder as `read-envoy.rb` and set:

* `USERNAME` - gmail username for sending data
* `PASSWORD` - gmail password for sending data
* `TO_EMAIL` - email to send alerts to
* `INVERTER_COUNT` - number of inverters you have.

Example contents of `.config`:

    USERNAME='some.burner.gmail.account'
    PASSWORD='gmai1@cc0untp@$$w0rd'
    TO_EMAIL='an.email.you.read@example.com'
    INVERTER_COUNT=48

## Install dependencies
`bundle install` or `sudo gem install ruby-gmail` depend on the user config running the script.

## Add cron
Add a crontab entry to run the `read-envoy.rb` script at a time of day (e.g., 12 noon) when you expect even a cloudy day to register *some* output.
