require "application_system_test_case"

class AdministeringEnrolmentRequestsTest < ApplicationSystemTestCase
  test "viewing a list of enrolment requests" do
    given_an_enrolment_request
    when_i_view_the_enrolment_requests_admin_index
    then_i_can_see_the_details_of_existing_enrolment_requests
  end

  private

  def given_an_enrolment_request
    EnrolmentRequest.create!(
      first_name: 'Bob',
      status: 'submitted',
      request_type: 'program_run'
    )
  end

  def when_i_view_the_enrolment_requests_admin_index
    visit admin_enrolment_requests_path
  end

  def then_i_can_see_the_details_of_existing_enrolment_requests
    assert_text 'Bob'
    assert_text 'submitted'
  end
end
