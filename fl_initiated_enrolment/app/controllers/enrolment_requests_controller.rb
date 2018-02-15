class EnrolmentRequestsController < ApplicationController
  before_action :find_or_create_enrolment_request

  def new
  end

  def create
    FutureLearnApi::EnrolmentRequest.new.patch(@enrolment_request.uuid, status: status)
    @enrolment_request.update!(status: status)

    redirect_to @enrolment_request.return_url
  end

  private

  def find_or_create_enrolment_request
    token = params[:token]

    if enrolment_request = EnrolmentRequest.find_by_token(token)
      @enrolment_request = enrolment_request
    else
      enrolment_request_hash = FutureLearnApi::EnrolmentRequest.new.token_exchange(token)

      @enrolment_request = EnrolmentRequest.new(
        uuid: enrolment_request_hash['uuid'],
        token: token,
        request_type: enrolment_request_hash['type'],
        learner_uuid: enrolment_request_hash['learner']['uuid'],
        return_url: enrolment_request_hash['return_url']
      )

      if enrolment_request_hash['type'] == 'degree'
        @enrolment_request.degree_uuid = enrolment_request_hash['degree']['uuid']
      elsif enrolment_request_hash['type'] == 'program_run'
        @enrolment_request.program_run_uuid = enrolment_request_hash['program_run']['uuid']
      end

      @enrolment_request.save!
      @enrolment_request
    end
  end
end
