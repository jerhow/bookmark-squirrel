class DemoController < ApplicationController
  def init
    ts = Time.now.strftime '%Y%m%d%H%M%S%L'
    name = "demo_#{ts}"
    pw = random_string(32)
    user = User.new(name: name, email: "#{name}@bookmarksquirrel.com", password: pw)
    user.save!
  end

  private

    def random_string(n)
      chars = Array('A'..'Z') + Array('a'..'z')
      Array.new(n) { chars.sample }.join
    end
end
