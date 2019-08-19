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


# These Group model references get used below
g1 = Group.first
g2 = Group.second
g3 = Group.third


# Users
(1..6).each do |i|
  if i < 3
    group = g1
  elsif i > 2 && i < 5
    group = g2
  else
    group = g3
  end

  group.users << User.create!(name: "User #{i}", email: "seeded_user_#{i}@example.com", password: ENV['SEED_USER_PASSWORD'])

end
puts "6 test users created across 3 test groups (2 per group)"

# Create an additional user that is a member all three groups
user_7 = User.create!(name: "User 7", email: "seeded_user_7@example.com")
g1.users << user_7
g2.users << user_7
g3.users << user_7
puts "1 additional test user created as a member of all three test groups"


# Bookmarks
num = 0
(1..15).each do |i|
  if i < 6
    group = g1
  elsif i > 5 && i < 11
    group = g2
  elsif i > 10
    group = g3
  end

  Bookmark.create!(title: "Bookmark #{i}", 
                     url: "https://example.com/test/#{i}", 
                     desc: "This is a seeded bookmark",
                     group_id: group.id)
end
puts "15 test bookmarks created across 3 test groups (5 bookmarks per group)"
