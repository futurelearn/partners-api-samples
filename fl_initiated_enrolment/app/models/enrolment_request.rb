class EnrolmentRequest < ApplicationRecord
  def confirmed?
    status == 'confirmed'
  end
end
