class BookmarksController < ApplicationController
  include GroupAccessConcern

  def index
    @groups = current_user.groups.order(created_at: :asc)
  end

  def show
    @showing_archived = params['show'] == "archived" ? true : false
    
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    
    if @showing_archived
      @bookmarks = @group.bookmarks.where(archived: true).order(created_at: :asc) if access_control(@group)
    else
      @bookmarks = @group.bookmarks.where(archived: false).order(created_at: :asc) if access_control(@group)
    end
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    bookmark = Bookmark.new(bookmark_params)
    group_id = bookmark.group_id
    authorize_access_to_group(group_id)
    
    respond_to do |format|
      if bookmark.save
        format.html { redirect_to action: "show", id: group_id }
        # format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        # format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        # format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bookmark = Bookmark.find_by(id: params[:id])
    @group_id = @bookmark.group.id
  end

  def update
    bookmark = Bookmark.find_by(id: params[:id])
    group_id = bookmark.group.id

    respond_to do |format|
      if bookmark.update(bookmark_params)
        flash[:success] = "Bookmark was successfully updated"
        format.html { redirect_to action: "show", id: group_id }
        # format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        # format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        # format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    bookmark = Bookmark.find_by(id: params[:id])
    group = bookmark.group
    group_id = group.id

    respond_to do |format|
      # Only proceed if this bookmark is rightly owned by a group that this user is a member of.
      if group.users.where(id: current_user.id).count == 1
        if bookmark.update!(archived: true)
          flash[:success] = "Bookmark was successfully archived"
          format.html { redirect_to action: "show", id: group_id }
        else
          flash[:failure] = "Oops, something went wrong when we tried to archive this bookmark"
          format.html { redirect_to action: "show", id: group_id }
        end
      end
    end
    
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :desc, :group_id)
    end
end
