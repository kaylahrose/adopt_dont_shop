class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def get_approval_message
    if self.approved
      "Approved"
    else
      "Rejected"
    end
  end
end
