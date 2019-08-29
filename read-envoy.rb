require 'gmail'
require 'net/http'
require 'json'

eval File.read('.config')

data = Net::HTTP.get('envoy.local', '/production.json')

parsed_data = JSON.parse(data)
production_data=parsed_data['production'][0]
active_count=production_data['activeCount']
watts_now=production_data['wNow']

exit unless active_count<INVERTER_COUNT || watts_now==0
gmail = Gmail.new(USERNAME, PASSWORD) do |gmail|
  gmail.deliver do
    to TO_EMAIL
    subject "#{production_data['activeCount']} inverters, #{production_data['wNow']} watts"
    text_part do
      body data
    end
  end
end
