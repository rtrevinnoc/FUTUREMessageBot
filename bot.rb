require "sinatra/base"
require "httparty"

class WhatsAppBot < Sinatra::Base
  use Rack::TwilioWebhookAuthentication, ENV['TWILIO_AUTH_TOKEN'], '/bot'

  post '/bot' do
    body = params["Body"]

    answer = HTTParty.get('https://wearebuildingthefuture.com/_answer', :query => {"query" => body})
    
    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      message.body(answer["result"]["small_summary"] + "\n\nSee more at https://wearebuildingthefuture.com/?q=" + body.gsub(/\s/, '+'))
    end

    content_type "text/xml"
    response.to_xml
  end
end
