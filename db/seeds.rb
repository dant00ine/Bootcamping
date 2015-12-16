# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(nick_name:  "7urkm3n",
             email: "rove@example.com",
             password:              "rr",
             password_confirmation: "rr",
             admin: true)

Profile.create!(first_name:  "Rovshen",
			 last_name: "Gurdov",
             contact_email: "rove@example.com",
             user_id: 1)

10.times do |n|
  name  = Faker::Name.name
  email = "example#{n+1}@example.com"
  password = "rr"

  User.create!(nick_name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
  Profile.create(first_name: name, contact_email: email, user_id: n+2)
end

50.times do |n|
  title  = Faker::Name.name
  email = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  image = "https://course_report_production.s3.amazonaws.com/rich/rich_files/rich_files/32/s300/code-fellows-logo.png"
  Bootcamp.create!(title:  title,
               about: email,
               bimage_url: image)
end

Profession.create(title: 'bootcamper')
Profession.create(title: 'recruiter')
