class BookmarksController < ApplicationController
  before_action :authorize
  
  def index
  end

  def show
  end

  def unauthorized
  end

  def unknown
  end

  private
    def can_access?
      group_id = params[:id]
      group = Group.find_by(title: group_id)
      
      if group.nil?
        render :unknown, status: :not_found
      else
        users = group.users
        user_ids = []
        
        users.each do |u|
          user_ids << u.id
        end

        user_ids.include? current_user.id
      end
    end

    def authorize
      if !can_access?
        render :unauthorized, status: :unauthorized
      end
    end
end
