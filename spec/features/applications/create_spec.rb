require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
  @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

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
      expect(find('form')).to have_content('Zip code')
    end
  end
end