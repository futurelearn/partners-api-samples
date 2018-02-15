class Admin::EnrolmentRequestsController < ApplicationController
  before_action :find_enrolment_request, only: [:confirm, :show]

  def index
    @degree_enrolment_requests = EnrolmentRequest.where(request_type: 'degree')
    @program_enrolment_requests = EnrolmentRequest.where(request_type: 'program_run')
  end

  def confirm
    organisation_membership_uuid = find_or_create_organisation_membership(params[:external_learner_id])

    if @enrolment_request.request_type == 'degree'
      degree_enrolment_uuid = confirm_degree_enrolment_request(organisation_membership_uuid)
      program_run_uuid = find_program_run_uuid
      create_program_enrolments(organisation_membership_uuid, program_run_uuid, degree_enrolment_uuid)
    else
      confirm_program_enrolment_request(organisation_membership_uuid)
    end

    @enrolment_request.update!(status: 'confirmed')

    flash[:notice] = 'Enrolment request successfully confirmed!'
    redirect_to admin_enrolment_requests_path
  end

  private

  def find_enrolment_request
    @enrolment_request = EnrolmentRequest.find(params[:id])
  end

  def confirm_degree_enrolment_request(organisation_membership_uuid)
    enrolment_request_hash = FutureLearnApi::EnrolmentRequest.new.patch(
      @enrolment_request.uuid,
      {
        organisation_membership: {
          uuid: organisation_membership_uuid,
        },
        status: 'confirmed'
      }
    )

    enrolment_request_hash['degree_enrolment']['uuid']
  end

  def create_program_enrolments(organisation_membership_uuid, program_run_uuid, degree_enrolment_uuid)
    FutureLearnApi::ProgramEnrolment.new.post(
      organisation_membership: {
        uuid: organisation_membership_uuid,
      },
      program_run: {
        uuid: program_run_uuid
      },
      degree_enrolment: {
        uuid: degree_enrolment_uuid
      }
    )
  end

  def find_program_run_uuid
    program_run_hash = FutureLearnApi::ProgramRun.new.find(params[:program_code], params[:program_run_code])

    program_run_hash['uuid']
  end

  def find_or_create_organisation_membership(external_learner_id)
    org_membership_hash = FutureLearnApi::OrganisationMembership.new.find(external_learner_id)
    org_membership_uuid = org_membership_hash['uuid']

    if org_membership_hash['uuid'].present?
      org_membership_hash['uuid']
    else
      org_membership_hash = FutureLearnApi::OrganisationMembership.new.post(
        external_learner_id: external_learner_id,
        learner: {
          uuid: @enrolment_request.learner_uuid
        }
      )

      org_membership_hash['uuid']
    end
  end

  def confirm_program_enrolment_request(organisation_membership_uuid)
    enrolment_request_hash = FutureLearnApi::EnrolmentRequest.new.patch(
      @enrolment_request.uuid,
      {
        organisation_membership: {
          uuid: organisation_membership_uuid,
        },
        status: 'confirmed'
      }
    )
  end
end
