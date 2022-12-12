# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
require 'rails_helper'

RSpec.describe 'admin shelter index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_3 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'displays all shelters in reverse alphabetical order by name' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
  end

#   As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelter's with Pending Applications"
# And in this section I see the name of every shelter that has a pending application
  it 'displays shelters with pending applications' do
    application = Application.create!(name: "Brittney Spears", 
      address: "000 Street Name",
      city: "City Name",
      state: "STATE",
      zipcode: 00000, 
      description: "I love animals and they love me!", 
      status: "Pending")
    application2 = Application.create!(name: "Donald Glover", 
          address: "000 Street Name",
          city: "City Name",
          state: "STATE",
          zipcode: 00000, 
          description: "I love animals and they love me!", 
          status: "Pending")      
    application3 = Application.create!(name: "Metro Boomin", 
          address: "000 Street Name",
          city: "City Name",
          state: "STATE",
          zipcode: 00000, 
          description: "I love animals and they love me!", 
          status: "In Progress")                               
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
    PetApplication.create!(pet: pet_1, application: application)
    PetApplication.create!(pet: pet_2, application: application)
    PetApplication.create!(pet: pet_2, application: application2)
    PetApplication.create!(pet: pet_1, application: application2)
    visit "/admin/shelters"
  
    
    within "div#pending_apps" do
      expect(page).to have_content("Shelters with Pending Applications:")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_no_content(@shelter_3.name)
    end
  end
end
