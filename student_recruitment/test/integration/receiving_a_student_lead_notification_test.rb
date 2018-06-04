require 'test_helper'

class ReceivingAStudentLeadNotificationTest < ActionDispatch::IntegrationTest
  setup do
    stub_student_leads_api_request
  end

  test 'receiving a student leads notification' do
    request_body = { uuid: student_lead_uuid, href: student_lead_api_href }.to_json
    signature = generate_signature(request_body)

    assert_difference 'StudentLead.count', 1, 'A StudentLead should be created' do
      post notify_student_leads_path, params: request_body, headers: { 'X-FL-Signature' => signature }
    end

    assert_response 202
  end

  private

  def stub_student_leads_api_request
    student_lead_response_body = {
      uuid: 'student-lead-uuid',
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'bob@email.com'
    }

    stub_request(:get, student_lead_api_href)
      .to_return(
        status: 200,
        body: student_lead_response_body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def student_lead_uuid
    'student-lead-uuid'
  end

  def student_lead_api_href
    'https://test.api/partners/students_leads/student-lead-uuid'
  end

  def generate_signature(request_body)
    Base64.strict_encode64(
      OpenSSL::HMAC.digest(
        'sha256',
        Rails.configuration.x.webhook_shared_secret, request_body)
    )
  end
end
