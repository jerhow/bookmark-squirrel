class GroupsController < ApplicationController
  def edit
    group_id = params[:id]
    user_id = current_user.id
    @group = Group.find_by(id: group_id)
  end
end
