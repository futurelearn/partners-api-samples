class EnrolmentRequestsController < ApplicationController
  before_action :find_enrolment_request, only: [:show, :update, :return_to_fl]

  def update
    @enrolment_request.update!(enrolment_request_attributes)
    redirect_to enrolment_request_path(@enrolment_request)
  end

  def apply
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
    end

    redirect_to enrolment_request_path(@enrolment_request)
  end

  def return_to_fl
    enrolment_request_attributes = FutureLearnApi::EnrolmentRequest.new.get(@enrolment_request.uuid)
    redirect_to enrolment_request_attributes['return_url']
  end

  private

  def find_enrolment_request
    @enrolment_request = EnrolmentRequest.find_by_id!(params[:id])
  end

  def enrolment_request_attributes
    params
      .require(:enrolment_request)
      .permit(:first_name, :last_name, :email)
  end
end
