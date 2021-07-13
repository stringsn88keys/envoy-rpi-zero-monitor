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
* `NEXMO_API_KEY` - API key from [nexmo settings page](https://dashboard.nexmo.com/settings)
* `NEXMO_API_SECRET` - API secret from above
* `NEXMO_SMS_FROM` - Phone number that your nexmo SMS will send from
* `NEXMO_SMS_TO` - Phone number to SMS notifications to
* `LATITUDE` - decimal representation of solar panels' latitude
* `LONGITUDE` - decimal representation of solar panels' longitude
* `TZ` - `TZInfo::Timezone` representation
* `ENVOY_HOST` - ip address or hostname (e.g., `envoy.local`) of your Envoy unit.
* `INVERTER_COUNT` - number of inverters the Envoy should detect.

Example contents of `.config`:
```ruby
    USERNAME='some.burner.gmail.account'
    PASSWORD='gmai1@cc0untp@$$w0rd'
    TO_EMAIL='an.email.you.read@example.com'
    NEXMO_API_KEY="3ab3789123"
    NEXMO_API_SECRET="123456sSD8dh"
    NEXMO_SMS_FROM="19281123581"
    NEXMO_SMS_TO="15551112222"
    LATITUDE=20.1237899
    LONGITUDE=-57.3364631
    TZ='America/Chicago'
    ENVOY_HOST='192.168.1.222'
    INVERTER_COUNT=100
```

## Install dependencies
(Requires ruby 2.4 for nexmo)
`bundle install` or `sudo gem install ruby-gmail tzinfo RubySunrise nexmo` depend on the user config running the script.

## Add cron
Add a crontab entry to run the `read-envoy.rb` script hourly or every 15 minutes as desired.
