require "./sendgrid/*"
require "http/client"

module Sendgrid
  class Client
    getter address : String
    getter api_key : String
    getter message : Message?

    def initialize(address, api_key)
      @address = address
      @api_key = api_key
    end

    def request_headers
      HTTP::Headers{
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }
    end

    def request_body
      message.to_json
    end

    def send(message : Message, body = nil)
      @message = message
      HTTP::Client.post(address, request_headers, body || request_body)
    end

  end
end
