require 'faraday'
require 'jwt'
require 'json'

module FutureLearnApi
  module Connection
    UNSUCCESSFUL_RESPONSE_CODES = (400..599).to_a

    private

    def connection
      Faraday.new(url: base_url).tap do |connection|
        connection.authorization(:Bearer, api_token)
        connection.response(:logger)
      end
    end

    def api_token
      consumer_key = api_config.fetch(:consumer_key)
      shared_secret = api_config.fetch(:shared_secret)

      JWT.encode(
        {
          iss: consumer_key,
          iat: Time.now.to_i
        },
        shared_secret,
        'HS256'
      )
    end

    def parse_json_response(response)
      fail '401 Unauthorized: please ensure that the shared secret and consumer key are configured correctly' if response.status.to_i == 401

      JSON.parse(response.body)
    end

    def base_url
      api_config.fetch(:base_url)
    end

    def api_config
      Rails.configuration.x.api_config
    end
  end
end
