class DemoController < ApplicationController
  skip_before_action :authenticate_user!, only: [:init]

  def init
    ts = Time.now.strftime '%Y%m%d%H%M%S%L'
    name = "demo_#{ts}"
    email = "#{name}@bookmarksquirrel.com"
    pw = random_string(32)
    user = User.new(name: name, email: email, password: pw)
    user.save!

    session[:demo_email] = email
    session[:demo_pw] = pw
    forward_to_login(email, pw)
  end

  private

    def forward_to_login(email, pw)
      redirect_to new_user_session_path, email: email, pw: pw
    end

    def random_string(n)
      chars = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
      Array.new(n) { chars.sample }.join
    end
end
