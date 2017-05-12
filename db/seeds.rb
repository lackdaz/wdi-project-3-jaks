# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 1.times do
#   User.create(
#     firstname: "testy",
#     email: "test@gmail.com",
#     encrypted_password: "$2a$11$TVSyRuLaSOiqWFBmjPTn8uSkYqHX9Z8l9Y.4fGYk2xUo2MiqIJgV.",
#     lastname: "test",
#     current_sign_in_at: DateTime.now,
#     last_sign_in_at: DateTime.now,
#     created_at: DateTime.now,
#     updated_at: DateTime.now,
#     confirmation_token: "12345",
#     confirmed_at: DateTime.now,
#     confirmation_sent_at: DateTime.now
#   )
# end

20.times do
  Supplier.create(
    name: Faker::Company.name,
    address: Faker::Address,
    contact: Faker::Number.number(8),
    lat: 1.3377969,
    lng: 103.846586,
    neighbourhood: "Toa Payoh",
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    website: Faker::Internet.url
  )
end
