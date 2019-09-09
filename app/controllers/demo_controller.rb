class DemoController < ApplicationController
  include DemoUserConcern
  skip_before_action :authenticate_user!, only: [:init]

  def init
    user, email, pw = create_new_demo_user
    seed_data(user)
    session[:demo_email] = email
    session[:demo_pw] = pw
    forward_to_login(email, pw)
  end

  def purge_expired_demo_users
    # Right now we're purging any demo accounts older than one hour ago
    interval_in_seconds = 3600

    return false if !current_user.admin?
      
    users = User.where('demo = ? and created_at < ?', true, (Time.now - interval_in_seconds))
    return false if users.count == 0
    
    users.each do |u|
      u.groups.each do |g|
        g.bookmarks.each do |b|
          b.delete
        end          
        g.delete
      end
      u.delete
    end

    flash[:success] = "Expired demo user purge complete. Check your results or logs."
    redirect_to show_user_path
    true
  end

  private

    def forward_to_login(email, pw)
      redirect_to new_user_session_path, email: email, pw: pw
    end
end
