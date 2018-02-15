class CreateEnrolmentRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolment_requests do |t|
      t.string :uuid
      t.string :token
      t.string :request_type
      t.string :status, default: 'new'
      t.string :learner_uuid
      t.string :degree_uuid
      t.string :program_run_uuid
      t.string :return_url
    end
  end
end
