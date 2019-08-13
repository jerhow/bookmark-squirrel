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

  def create
    @bookmark = Bookmark.new(bookmark_params)
    group_id = @bookmark.group_id
    # TODO: Authorize group_id against the current user id!!!
    
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to action: "show", id: group_id }
        # format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        # format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        # format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :desc, :group_id)
    end
end
