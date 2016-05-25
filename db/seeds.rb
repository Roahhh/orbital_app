# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create!(first_name:  "Administrator",
             last_name: "1",
             identity_no: "admin1",
             email: "admin1@roleplay.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  identity_no = "S" + Faker::PhoneNumber.subscriber_number(8).to_s + ('A'..'Z').to_a.sample
  email = "example-#{n+1}@roleplay.org"
  password = "password"

  User.create!(first_name:  first_name,
  	           last_name: last_name,
  	           identity_no: identity_no,
               email: email,
               password:              password,
               password_confirmation: password,
               luck: rand(100))
end