class GroupsController < ApplicationController
  include GroupAccessConcern

  before_action :redirect_to_user_groups, only: [:index, :show]

  def index
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.users << current_user

    respond_to do |format|
        if group.save!
          flash[:success] = "Group '#{group.title}' was successfully created"
          format.html { redirect_to root_path }
        else
          flash[:notice] = "Oops, there was a problem creating this group :/"
          format.html { render :new }
        end
      end
  end

  def edit
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    @users_in_group = @group.users.order(name: :asc) if access_control(@group)
  end

  def update
    group = Group.find_by(id: params[:id])

    if current_user_owns_group?(group)

      respond_to do |format|
        if group.update!(group_params)
          flash[:success] = "Group was successfully updated"
          format.html { redirect_to action: "edit", id: group.id }
        else
          flash[:notice] = "Oops, there was a problem updating this group :/"
          format.html { render :edit }
        end
      end
    
    end
  end

  def delete_user
    group = Group.find_by(id: params[:group_id])
    remove_this_user_from_group = User.find_by(id: params[:user_id])

    if current_user_owns_group?(group) && current_user.id != remove_this_user_from_group.id

      success = !group.users.delete(remove_this_user_from_group).nil?

      respond_to do |format|
        if success
          flash[:success] = "User #{remove_this_user_from_group.name}  " +
            "was successfully removed from this group"
          format.html { redirect_to action: "edit", id: group.id }
        else
          flash[:notice] = "Oops, there was a problem removing user " +
          "#{remove_this_user_from_group.name} from this group :/"
          format.html { render :edit }
        end
      end

    end
  end

  def new_user
    @group = Group.find_by(id: params[:group_id])
    if !current_user_owns_group?(@group)
      redirect_back fallback_location: '/', allow_other_host: false
    end
  end

  def add_user
    group = Group.find_by(id: params[:group_id])
    
    if current_user_owns_group?(group)
    
      email = params['email']
      user = User.find_by(email: email)
      user = User.new if user.nil?

      respond_to do |format|
        if user.id == current_user.id
          flash[:notice] = "'#{email}' is you, and you're already in this group :)"
          format.html { redirect_to action: "new_user" }
        elsif user_in_group?(user, group)
          flash[:notice] = "A user with the email '#{email}' is already in this group"
          format.html { redirect_to action: "new_user" }
        elsif user_exists?(user)
          group.users << user # The fact that this works is fucking great.
          flash[:notice] = "User '#{user.name}' has been added to the group"
          format.html { redirect_to action: "edit", id: group.id }
        else
          flash[:notice] = "Oops, '#{email}' is not a BookmarkSquirrel user, " +
            "which is necessary to be in a group. They should register :)"
          format.html { redirect_to action: "new_user" }
        end

      end
      
    end
  end

  private

    def user_in_group?(user, group)
      users = group.users
      user_ids = []
      
      users.each do |u|
        user_ids << u.id
      end

      user_ids.include? user.id
    end

    def user_exists?(user)
      !(user.nil? || user.id.nil?)
    end

    def current_user_owns_group?(group)
      current_user.id == group.owner_user_id
    end

    def redirect_to_user_groups
      respond_to do |format|
        format.html { redirect_to user_groups_path }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title)
    end
end
