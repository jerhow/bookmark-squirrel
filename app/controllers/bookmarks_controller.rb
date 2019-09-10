class BookmarksController < ApplicationController
  include GroupAccessConcern

  def index
    @groups = current_user.groups.order(created_at: :asc)
  end

  def show
    sort_options = {
      "name_asc" => "title ASC",
      "name_desc" => "title DESC",
      "created_asc" => "created_at ASC",
      "created_desc" => "created_at DESC"
    }

    sort_param = params[:sort] ? params[:sort] : "created_desc"
    order_clause = sort_options[sort_param]
    @sorted_by = sort_param

    @showing_archived = params[:show] == "archived" ? true : false
    
    group_id = params[:id]
    @group = Group.find_by(id: group_id)

    @bookmarks = @group.bookmarks.where(archived: @showing_archived).order(order_clause) if access_control(@group)
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
      else
        format.html { render :new }
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
    
    if bookmark_params['title'].strip == ""
      flash[:alert] = "Title cannot be blank"
      redirect_to edit_bookmark_path(bookmark)
      return false
    end

    if bookmark_params['url'].strip == ""
      flash[:alert] = "URL cannot be blank"
      redirect_to edit_bookmark_path(bookmark)
      return false
    end

    respond_to do |format|
      if bookmark.update(bookmark_params)
        flash[:success] = "Bookmark was successfully updated"
        format.html { redirect_to action: "show", id: group_id }
      else
        format.html { render :edit }
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

  def restore
    bookmark = Bookmark.find_by(id: params[:id])
    group = bookmark.group
    group_id = group.id

    respond_to do |format|
      # Only proceed if this bookmark is rightly owned by a group that this user is a member of.
      if group.users.where(id: current_user.id).count == 1
        if bookmark.update!(archived: false)
          flash[:success] = "Bookmark was successfully restored"
          format.html { redirect_to action: "show", id: group_id }
        else
          flash[:failure] = "Oops, something went wrong when we tried to restore this bookmark"
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
