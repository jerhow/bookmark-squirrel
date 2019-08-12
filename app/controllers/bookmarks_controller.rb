class BookmarksController < ApplicationController
  before_action :setup, only: [:show]
  before_action :access_control, only: [:show]
  
  def index
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def unauthorized
  end

  def unknown
  end

  private

    def setup
      @group_id = params[:id]
      @group = Group.find_by(id: @group_id)
    end

    def access_control
      if !group_exists? # 404
        render :unknown, status: :not_found
        return false
      end

      if !user_can_access_group? # 401
        render :unauthorized, status: :unauthorized
        return false
      end
    end

    def group_exists?
      !@group.nil?
    end

    def user_can_access_group?
      users = @group.users
      user_ids = []
      
      users.each do |u|
        user_ids << u.id
      end

      user_ids.include? current_user.id
    end
end
