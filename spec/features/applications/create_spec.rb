require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'displays link to start application' do
      visit '/pets' 
  
      expect(page).to have_content("Start an Application")
  
      click_on("Start an Application")
      expect(current_path).to eq('/applications/new')
    end

    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'the application create' do
    it 'creates the application and redirects to the application show page' do

      visit "/applications/new"

      fill_in 'Name', with: 'Jeremy Mitchell'
      fill_in 'Address', with: '000 Main Street'
      fill_in 'City', with: 'San Francisco'
      fill_in 'State', with: 'California'
      fill_in 'Zipcode', with: 94122 
      fill_in 'Description', with: "I love pets" 
      
      click_button 'Submit'
      new_app = Application.last

      expect(page).to have_current_path("/applications/#{new_app.id}")
      expect(page).to have_content('Jeremy')
      expect(page).to have_content('000 Main Street')
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('California')
      expect(page).to have_content('94122')
      expect(page).to have_content('I love pets')
      expect(page).to have_content('In Progress')
      expect(new_app.status).to eq("In Progress")
    end

    it 'does not create an application if any form fields are unfilled and specifies that all fields must be filled' do
      visit "/applications/new"

      fill_in 'Address', with: '000 Main Street'
      fill_in 'City', with: 'San Francisco'
      fill_in 'State', with: 'California'
      fill_in 'Zipcode', with: 94122 

      click_button 'Submit'

      expect(page).to have_content("New Application")
      expect(page).to have_field("Name")
      expect(page).to have_field("Address")
      expect(page).to have_button("Submit")
      expect(page).to have_content("Application not created: All fields must be filled to submit.")
      expect(page).to have_current_path("/applications/new")
    end
  end
end