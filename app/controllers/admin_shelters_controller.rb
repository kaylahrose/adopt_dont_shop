class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("select name from shelters order by name desc")
    @shelters_with_pending_applications = Shelter.get_shelters_with_pending_applications
  end
end