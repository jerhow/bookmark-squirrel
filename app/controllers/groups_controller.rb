class GroupsController < ApplicationController
  include GroupAccessConcern

  def edit
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    @users_in_group = @group.users.order(name: :asc) if access_control(@group)
  end

  def update
    group = Group.find_by(id: params[:id])

    if user_owns_group?(group)

      respond_to do |format|
        if group.update(group_params)
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

    if user_owns_group?(group)

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

  private

    def user_owns_group?(group)
      current_user.id == group.owner_user_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title)
    end
end
