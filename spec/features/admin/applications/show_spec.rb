
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

    expect(current_path).to eq("/admin/applications/#{application.id}")
    within "div#pet-#{pet_1.id}" do
      expect(page).to have_no_button("Approve for adoption")
      expect(page).to have_content("Approved")
    end

    within "div#pet-#{pet_2.id}" do
      expect(page).to have_button("Approve for adoption")
    end
  end
   
  it 'has button to reject pet adoption' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
    application = Application.create!(name: "Metro Boomin", 
        address: "000 Street Name",
        city: "City Name",
        state: "STATE",
        zipcode: 00000, 
        description: "I love animals and they love me!", 
        status: "Pending")                               
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
    PetApplication.create!(pet: pet_1, application: application)
    PetApplication.create!(pet: pet_2, application: application)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    within "div#pet-#{pet_1.id}" do
      expect(page).to have_button("Reject for adoption")
      click_button "Reject for adoption"
    end

    expect(current_path).to eq("/admin/applications/#{application.id}")
    within "div#pet-#{pet_1.id}" do
      expect(page).to have_no_button("Reject for adoption")
      expect(page).to have_content("Rejected")
    end

    within "div#pet-#{pet_2.id}" do
      expect(page).to have_button("Reject for adoption")
    end
  end

  it 'rejecting or approving a pet for adoption on one application does not change the pets status in another application' do 
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
    application_1 = Application.create!(name: "Metro Boomin", 
        address: "000 Street Name",
        city: "City Name",
        state: "STATE",
        zipcode: 00000, 
        description: "I love animals and they love me!", 
        status: "Pending")
    application_2 = Application.create!(name: "Nas", 
        address: "000 Street Name",
        city: "City Name",
        state: "STATE",
        zipcode: 00000, 
        description: "I love animals and they love me!",          
        status: "Pending")                               
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
    PetApplication.create!(pet: pet_1, application: application_1)
    PetApplication.create!(pet: pet_2, application: application_1)
    PetApplication.create!(pet: pet_1, application: application_2)
    PetApplication.create!(pet: pet_2, application: application_2)

    visit "/admin/applications/#{application_1.id}"

    within "div#pet-#{pet_1.id}" do
      click_button "Approve for adoption"
    end
    within "div#pet-#{pet_2.id}" do
      click_button "Reject for adoption"
    end

    visit "/admin/applications/#{application_2.id}"

    within "div#pet-#{pet_1.id}" do
      expect(page).to have_button("Reject for adoption")
      expect(page).to have_button("Approve for adoption")
    end
    within "div#pet-#{pet_2.id}" do
      expect(page).to have_button("Reject for adoption")
      expect(page).to have_button("Approve for adoption")
    end
  end
end