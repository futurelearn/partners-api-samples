require "application_system_test_case"

class ApplyingToJoinADegreeTest < ApplicationSystemTestCase
  setup do
    stub_futurelearn_partners_api
  end

  test "a user submitting an application for a degree program" do
    when_i_am_directed_to_the_degree_program_application_form_from_futurelearn
    then_the_application_form_is_prefilled_with_my_information
    and_when_i_submit_the_application
    then_i_am_redirected_to_the_enrolment_request_return_url
  end

  private

  def when_i_am_directed_to_the_degree_program_application_form_from_futurelearn
    visit apply_url(token: enrolment_request_token)
  end

  def then_the_application_form_is_prefilled_with_my_information
    assert_field 'First name', 'Bob'
    assert_field 'Last name', 'Smith'
    assert_field 'Email', 'bob@email.com'
  end

  def and_when_i_submit_the_application
    click_on 'Submit application'
  end

  def then_i_am_redirected_to_the_enrolment_request_return_url
    assert_current_path return_url
  end

  def stub_futurelearn_partners_api
    stub_token_exchange_api_request
    stub_learner_details_api_request
    stub_program_run_api_request
    stub_program_api_request
    stub_update_enrolment_request_api_request
  end

  def stub_token_exchange_api_request
    enrolment_request_response_body = {
      learner: { uuid: learner_uuid },
      program_run: {
        uuid: program_run_uuid
      },
      type: 'program_run',
      uuid: enrolment_request_uuid
    }

    stub_request(:post, 'https://test.api/partners/enrolment_requests/token_exchange')
      .with(body: { token: enrolment_request_token })
      .to_return(
        status: 200,
        body: enrolment_request_response_body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def stub_learner_details_api_request
    learner_details_response_body = {
      uuid: learner_uuid,
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'bob@email.com'
    }

    stub_request(:get, 'https://test.api/partners/learners/' + learner_uuid)
      .to_return(
        status: 200,
        body: learner_details_response_body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def stub_program_run_api_request
    program_run_details_response_body = {
      code: 'program-code',
      program: {
        uuid: program_uuid
      }
    }

    stub_request(:get, 'https://test.api/partners/program_runs/' + program_run_uuid)
      .to_return(
        status: 200,
        body: program_run_details_response_body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def stub_program_api_request
    program_details_response_body = {
      code: 'program-code',
      title: 'program-title'
    }

    stub_request(:get, 'https://test.api/partners/programs/' + program_uuid)
      .to_return(
        status: 200,
        body: program_details_response_body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def stub_update_enrolment_request_api_request
    stub_request(:patch, 'https://test.api/partners/enrolment_requests/' + enrolment_request_uuid)
      .with(body: { status: 'submitted' })
      .to_return(
        status: 200,
        body: { return_url: return_url, status: 'submitted' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def enrolment_request_token
    'enrolment-request-token'
  end

  def enrolment_request_uuid
    'enrolment-request-uuid'
  end

  def learner_uuid
    'learner-uuid'
  end

  def program_run_uuid
    'program-run-uuid'
  end

  def program_uuid
    'program-uuid'
  end

  def return_url
    'https://example.com'
  end
end
