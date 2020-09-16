# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false,
               )
end
20.times do |n|
  title = Faker::Music.band
  content= Faker::Music.album
  Task.create!(title: title,
               content: content,
               deadline: '2019'
               )
end
10.times do |n|
  Label.create!([name: "Task#{n + 1}"])
end
User.create!(name: "admin01",
             email: "admin01@sample.com",
             password: "aaaaaa",
             password_confirmation: "aaaaaa",
             admin: true,
           )
