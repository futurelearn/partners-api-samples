class CreateStudentLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :student_leads do |t|
      t.string :uuid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps
    end
  end
end
