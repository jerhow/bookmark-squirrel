module DemoUserConcern
  extend ActiveSupport::Concern

  def create_new_demo_user(name = "")
    ##
    # Default behavior is to let the method set the name on this user, but it can be overridden
    # by passing in whatever you want.
    #
    # NOTE: Returns an array of things, so destructure when you call this or expect an array back
    #
    ts = timestamp
    name = "Demo User" if name == ""
    email = "demo_#{ts}@bookmarksquirrel.com"
    pw = random_string(32)
    user = User.new(name: name, email: email, password: pw, demo: true)
    user.save!
    [user, email, pw]
  end

  def timestamp
    Time.now.strftime '%Y%m%d%H%M%S%L'
  end

  def random_string(n)
    chars = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    Array.new(n) { chars.sample }.join
  end

  def seed_data(demo_user)
    # Create demo groups
    group_1 = Group.new(title: "Top Sites", owner_user_id: demo_user.id)
    group_1.save!
    group_2 = Group.new(title: "E-Commerce", owner_user_id: demo_user.id)
    group_2.save!
    group_3 = Group.new(title: "Tech", owner_user_id: demo_user.id)
    group_3.save!

    # Create demo users
    user_1, _, _ = create_new_demo_user("Maggie Demo")
    user_2, _, _ = create_new_demo_user("Fiona Demo")
    user_3, _, _ = create_new_demo_user("Ben Demo")

    # Assign demo users to demo groups
    group_1.users << demo_user
    group_1.users << user_1
    group_1.users << user_2
    group_1.users << user_3
    group_2.users << demo_user
    group_2.users << user_1
    group_2.users << user_2
    group_2.users << user_3
    group_3.users << demo_user
    group_3.users << user_1
    group_3.users << user_2
    group_3.users << user_3

    # Create some demo bookmarks
    # Group 1
    Bookmark.create!(title: "Cryptome", url: "https://cryptome.org", desc: "Cryptome homepage", group_id: group_1.id)
    Bookmark.create!(title: "The Intercept", url: "https://theintercept.com", desc: "The Intercept homepage", group_id: group_1.id)
    Bookmark.create!(title: "DuckDuckGo", url: "https://duckduckgo.com", desc: "DuckDuckGo homepage", group_id: group_1.id)
    Bookmark.create!(title: "Wikipedia", url: "https://wikipedia.org", desc: "Wikipedia homepage", group_id: group_1.id)
    Bookmark.create!(title: "Bing", url: "https://bing.com", desc: "Bing homepage", group_id: group_1.id)
    Bookmark.create!(title: "MSN", url: "https://msn.com", desc: "MSN homepage", group_id: group_1.id)
    Bookmark.create!(title: "Twitter", url: "https://twitter.com", desc: "Twitter homepage", group_id: group_1.id)
    Bookmark.create!(title: "YouTube", url: "https://youtube.com", desc: "YouTube homepage", group_id: group_1.id)
    Bookmark.create!(title: "Yahoo", url: "https://yahoo.com", desc: "Yahoo homepage", group_id: group_1.id)
    Bookmark.create!(title: "Google", url: "https://google.com", desc: "Google homepage", group_id: group_1.id)    

    # Group 2
    Bookmark.create!(title: "Craig's List", url: "https://craigslist.org", desc: "Craigslist homepage", group_id: group_2.id)
    Bookmark.create!(title: "Squarespace", url: "https://squarespace.com", desc: "Squarespace homepage", group_id: group_2.id)
    Bookmark.create!(title: "Etsy", url: "https://etsy.com", desc: "Etsy homepage", group_id: group_2.id)
    Bookmark.create!(title: "eBay", url: "https://ebay.com", desc: "eBay homepage", group_id: group_2.id)
    Bookmark.create!(title: "Shopify", url: "https://shopify.org", desc: "Shopify homepage", group_id: group_2.id)
    Bookmark.create!(title: "Amazon", url: "https://amazon.com", desc: "Amazon homepage", group_id: group_2.id)

    # Group 3
    Bookmark.create!(title: "LWN.net", url: "https://lwn.net/", desc: "LWN.net homepage", group_id: group_3.id)    
    Bookmark.create!(title: "PerlMonks", url: "https://www.perlmonks.org/", desc: "PerlMonks homepage", group_id: group_3.id)
    Bookmark.create!(title: "Clojure.org", url: "https://clojure.org/", desc: "Clojure homepage", group_id: group_3.id)
    Bookmark.create!(title: "Ruby Gems", url: "https://rubygems.org/", desc: "Clojure homepage", group_id: group_3.id)
    Bookmark.create!(title: "OpenBSD Journal", url: "https://undeadly.org/", desc: "OpenBSD Journal homepage", group_id: group_3.id)
    Bookmark.create!(title: "Commodore Computers archive", url: "https://www.commodore.ca/", desc: "Commodore Computers archive homepage", group_id: group_3.id)
    Bookmark.create!(title: "Lobsters", url: "https://lobste.rs/", desc: "Lobsters homepage", group_id: group_3.id)
    Bookmark.create!(title: "Slashdot", url: "https://slashdot.org", desc: "Slashdot homepage", group_id: group_3.id)
    Bookmark.create!(title: "Hacker News", url: "https://news.ycombinator.com", desc: "Hacker News homepage", group_id: group_3.id)
  end

end
