# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

row_count = 5

row_count.times do |num|
  Bookmark.create!(title: "Seeded bookmark #{num}", 
                     url: "https://example.com/test/#{num}", 
                     desc: "This bookmark was seeded by Rails")
end
puts "#{row_count} bogus bookmarks created"

row_count.times do |num|
  User.create!(name: "Seeded user #{num}", email: "seeded_user_#{num}@example.com")
end
puts "#{row_count} bogus users created"

row_count.times do |num|
  Group.create!(title: "Seeded group #{num}")
end
puts "#{row_count} bogus groups created"
