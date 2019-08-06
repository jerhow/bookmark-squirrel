# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Groups
(1..3).each do |group_num|
  Group.create!(title: "Group #{group_num}")
end
puts "3 test groups created"


# These get used below
g1 = Group.first
g2 = Group.second
g3 = Group.third


# Users
(1..6).each do |i|
  if i < 3
    group_id = g1.id
  elsif i > 2 && i < 5
    group_id = g2.id
  else
    group_id = g3.id
  end

  User.create!(name: "User #{i}", email: "seeded_user_#{i}@example.com", group_id: group_id)
end
puts "6 test users created across 3 groups"


# Bookmarks
num = 0
(1..15).each do |i|
  if i < 6
    group_id = g1.id
  elsif i > 5 && i < 11
    group_id = g2.id
  elsif i > 10
    group_id = g3.id
  end

  Bookmark.create!(title: "Bookmark #{i}", 
                     url: "https://example.com/test/#{i}", 
                     desc: "This is a seeded bookmark",
                     group_id: group_id)
end
puts "15 test bookmarks created across 3 groups"
