# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "erasing pre-existing users..."
User.destroy_all
puts "erasing pre-existing events..."
Event.destroy_all
puts "erasing pre-existing attendances..."
Attendance.destroy_all

10.times do
  User.create!(email: Faker::Name.first_name + "@yopmail.com", description: Faker::TvShows::BojackHorseman, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name )
end

10.times do
  Event.create!(start_date: Faker::Date.forward(30), duration: (rand(6..60)*5), title: Faker::IndustrySegments.industry, description: Faker::Lorem.paragraph, price: rand(1..1000), location: Faker::Address.city, admin_id: User.all.sample.id)
end

20.times do
  Attendance.create!(event_id: Event.all.sample.id, attendee_id: User.all.sample.id)
end
