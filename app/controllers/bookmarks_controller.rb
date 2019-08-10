class BookmarksController < ApplicationController
  before_action :authorize
  
  def index
  end

  def show
  end

  private
    def can_access?
      group_id = params[:id]
      users = Group.find_by(title: group_id).users
      user_ids = []
      
      users.each do |u|
        user_ids << u.id
      end

      user_ids.include? current_user.id
    end

    def authorize
      if can_access?
        puts "BOOSH"
      else
        puts "KAKOW"
      end
    end
end
