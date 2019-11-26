require 'gmail'
require 'net/http'
require 'json'
require 'solareventcalculator'
require 'date'
require 'nexmo'

eval File.read('.config')

data = Net::HTTP.get(ENVOY_HOST, '/production.json')

parsed_data = JSON.parse(data)
production_data=parsed_data['production'][0]
active_count=production_data['activeCount']
watts_now=production_data['wNow']
wh_lifetime=production_data['whLifetime']

sms_message="Solar output down!"

client = Nexmo::Client.new(
  api_key: NEXMO_API_KEY,
  api_secret: NEXMO_API_SECRET
)

sec = SolarEventCalculator.new(Date.today, LATITUDE, LONGITUDE)
tz=TZInfo::Timezone.get(TZ)
sunrise = tz.to_local(sec.compute_utc_official_sunrise)
sunset = tz.to_local(sec.compute_utc_official_sunset)
time_now = tz.to_local(DateTime.now)

exit unless active_count < INVERTER_COUNT || watts_now==0

if time_now > sunrise && time_now < sunset
  client.sms.send(
    from: NEXMO_SMS_FROM,
    to: NEXMO_SMS_TO,
    text: sms_message
  )
end

Gmail.new(USERNAME, PASSWORD) do |gmail|
  gmail.deliver do
    to TO_EMAIL
    subject "#{production_data['activeCount']} inverters, #{production_data['wNow']} watts"
    text_part do
      body data
    end
  end
end
