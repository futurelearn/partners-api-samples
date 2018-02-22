class StudentLeadsController < ApplicationController
  before_action :check_request_signature, only: :notify
  skip_before_action :verify_authenticity_token, only: :notify

  def index
    @student_leads = StudentLead.all
  end

  def notify
    payload = JSON.parse(request.raw_post)
    student_lead_href = payload['href']
    student_lead_response = api_connection.get(student_lead_href)

    student_lead_attributes = JSON.parse(student_lead_response.body)

    StudentLead.create!(student_lead_attributes.slice(
      'uuid', 'first_name', 'last_name', 'email'))

    head :accepted
  end

  private

  def api_connection
    @api_connection ||= Faraday.new do |c|
      c.authorization(:Bearer, bearer_token)
      c.response :logger
      c.response :raise_error
      c.adapter Faraday.default_adapter
    end
  end

  def bearer_token
    JWT.encode(
      {
        iss: Rails.configuration.x.api_consumer_key,
        iat: Time.now.to_i
      },
      Rails.configuration.x.api_shared_secret,
      'HS256'
    )
  end

  def check_request_signature
    expected_signature = Base64.strict_encode64(
      OpenSSL::HMAC.digest('sha256', Rails.configuration.x.webhook_shared_secret, request.raw_post))
    actual_signature = request.headers['X-FL-Signature']

    head :bad_request unless Rack::Utils.secure_compare(expected_signature, actual_signature)
  end
end
