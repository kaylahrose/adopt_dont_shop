# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    @pet_5 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

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

PetApplication.create!(pet: @pet_1, application: application)
PetApplication.create!(pet: @pet_2, application: application)
PetApplication.create!(pet: @pet_5, application: application2)
PetApplication.create!(pet: @pet_3, application: application3)