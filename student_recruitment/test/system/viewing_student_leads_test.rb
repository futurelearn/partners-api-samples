require "application_system_test_case"

class ViewingStudentLeadsTest < ApplicationSystemTestCase
  test 'viewing a list of student leads' do
    given_a_student_lead_exists
    when_i_visit_the_student_leads_index
    then_i_can_see_the_lead_details
  end

  private

  def given_a_student_lead_exists
    @student_lead = StudentLead.create!(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'bob@email.com'
    )
  end

  def when_i_visit_the_student_leads_index
    visit student_leads_path
  end

  def then_i_can_see_the_lead_details
    assert_text 'Bob'
    assert_text 'Smith'
    assert_text 'bob@email.com'
  end
end
