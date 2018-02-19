class RemoveReturnUrlFromEnrolmentRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :enrolment_requests, :return_url
  end
end
