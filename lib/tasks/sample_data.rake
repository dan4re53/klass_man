namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar", 
                 password_confirmation: "foobar",
                 phone: "1234567890",
                 admin: true )
    admin2 = User.create!(name: "Example User2",
                  email: "example2@railstutorial.org",
                  password: "foobar", 
                  password_confirmation: "foobar",
                  phone: "1234567890",
                  admin: true )
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      phone = "1231231234"
      grade = rand(9..12)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   phone: phone,
                   grade: grade)
      end
    end
  end