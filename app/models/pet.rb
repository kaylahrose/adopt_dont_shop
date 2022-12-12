class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def get_applications
    pet_apps = PetApplication.where(:pet_id == self.id)
    pet_apps = pet_apps.map do |pet_app|
      Application.find(pet_app[:application_id])
    end
  end
end
