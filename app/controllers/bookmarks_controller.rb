class BookmarksController < ApplicationController  
  def index
  end

  def show
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    access_control(@group)
    @bookmarks = @group.bookmarks.where(archived: false)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    group_id = @bookmark.group_id
    authorize_access_to_group(group_id)
    
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

  private

    def authorize_access_to_group(group_id)
      group = Group.find_by(id: group_id)

      if !group_exists?(group)
        puts "\nHits the GROUP DOESN'T EXIST condition!\n"
        format.html { render :new }
        return false
      end

      if !user_can_access_group?(group)
        puts "\nHits the NO GROUP ACCESS condition!\n"
        format.html { render :new }
        return false
      end
    end

    def access_control(group)
      if !group_exists?(group)
        render :unknown, status: :not_found # 404
        return false
      end

      if !user_can_access_group?(group)
        render :unauthorized, status: :unauthorized # 401
        return false
      end
    end

    def group_exists?(group)
      !group.nil?
    end

    def user_can_access_group?(group)
      users = group.users
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
