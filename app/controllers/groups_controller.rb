class GroupsController < ApplicationController
  include GroupAccessConcern

  def edit
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    @users_in_group = @group.users.order(name: :asc) if access_control(@group)
  end

  def update
    group = Group.find_by(id: params[:id])
    
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title)
    end
end
