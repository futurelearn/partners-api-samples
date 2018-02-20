module EnrolmentRequestsHelper
  def enrolment_request_status_options(enrolment_request)
    options_for_select({
      'New (Unsubmitted)' => 'new',
      'Submitted' => 'submitted',
      'Provisionally Accepted' => 'accepted',
      'Cancelled' => 'cancelled',
      'Declined' => 'declined'
    }, enrolment_request.status)
  end
end
