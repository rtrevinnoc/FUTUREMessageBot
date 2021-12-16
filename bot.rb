require "sinatra/base"

class WhatsAppBot < Sinatra::Base
  #use Rack::TwilioWebhookAuthentication, ENV['TWILIO_AUTH_TOKEN'], '/bot'

  post '/bot' do
    body = params["Body"].downcase
    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      if body.include?("hi")
        message.body("Hello!")
      elsif body.include?("goodbye")
        message.body("Goodbye!")
      else
        message.body("Can't recognize it")
      end
    end

    content_type "text/xml"
    response.to_xml
  end
end
