require "sinatra/base"
require "httparty"

class WhatsAppBot < Sinatra::Base
  #use Rack::TwilioWebhookAuthentication, ENV['TWILIO_AUTH_TOKEN'], '/bot'

  post '/bot' do
    body = params["Body"].downcase

    answer = HTTParty.get('https://wearebuildingthefuture.com/_answer', :query => {"query" => body})
    
    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      if body.include?("hi")
        message.body("Hello!")
      elsif body.include?("goodbye")
        message.body("Goodbye!")
      else
        message.body(answer["result"]["small_summary"])
      end
    end

    content_type "text/xml"
    response.to_xml
  end
end
