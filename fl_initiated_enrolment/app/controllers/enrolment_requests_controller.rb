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
      enrolment_request_attributes = FutureLearnApi::EnrolmentRequest.new.token_exchange(token)
      learner_attributes = FutureLearnApi::Learner.new.get(enrolment_request_attributes['learner']['uuid'])

      @enrolment_request = EnrolmentRequest.new(
        uuid: enrolment_request_attributes['uuid'],
        token: token,
        request_type: enrolment_request_attributes['type'],
        first_name: learner_attributes['first_name'],
        last_name: learner_attributes['last_name'],
        email: learner_attributes['email']
      )

      if enrolment_request_attributes['type'] == 'degree'
        degree_attributes = FutureLearnApi::Degree.new.get(enrolment_request_attributes['degree']['uuid'])

        @enrolment_request.degree_code = degree_attributes['code']
        @enrolment_request.degree_title = degree_attributes['title']
      elsif enrolment_request_attributes['type'] == 'program_run'
        program_run_attributes = FutureLearnApi::ProgramRun.new.get(enrolment_request_attributes['program_run']['uuid'])
        program_attributes = FutureLearnApi::Program.new.get(program_run_attributes['program']['uuid'])

        @enrolment_request.program_title = program_attributes['title']
        @enrolment_request.program_code = program_attributes['code']
        @enrolment_request.program_run_code = program_run_attributes['code']
      end

      @enrolment_request.save!
      @enrolment_request
    end
  end
end
