# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

require 'rails_helper'

RSpec.describe 'the admin applications show page' do
  it 'has button to approve pet adoption' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
    application = Application.create!(name: "Metro Boomin", 
        address: "000 Street Name",
        city: "City Name",
        state: "STATE",
        zipcode: 00000, 
        description: "I love animals and they love me!", 
        status: "In Progress")                               
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
    PetApplication.create!(pet: pet_1, application: application)
    PetApplication.create!(pet: pet_2, application: application)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    within "div#pet-#{pet_1.id}" do
      expect(page).to have_button("Approve for adoption")
      click_button "Approve for adoption"
    end

    expect(current_path).to eq("admin/applications/#{application.id}")
    within "div#pet-#{pet_1.id}" do
      expect(page).to have_no_button("Approve for adoption")
      expect(page).to have_content("Approved")
    end

    within "div#pet-#{pet_2.id}" do
      expect(page).to have_button("Approve for adoption")
    end

  # add additional column to join table
  # drop database, then delete migration file for pet app, recreate pet app with additional column called approved, boolean, no validation to accept nil as default
  # branching in view, first branch, "when bool column is nil, then button is rendered to approve pet for the application", 
  # second branch, "call a method on the pet (new model method) that retrieves an approve/rejection message"
  end
end