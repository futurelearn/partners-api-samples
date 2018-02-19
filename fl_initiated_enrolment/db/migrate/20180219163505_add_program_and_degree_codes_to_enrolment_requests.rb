class AddProgramAndDegreeCodesToEnrolmentRequests < ActiveRecord::Migration[5.1]
  def change
    change_table :enrolment_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :degree_title
      t.string :degree_code
      t.string :program_title
      t.string :program_code
      t.string :program_run_code
      t.remove :learner_uuid
      t.remove :degree_uuid
      t.remove :program_run_uuid
    end
  end
end
