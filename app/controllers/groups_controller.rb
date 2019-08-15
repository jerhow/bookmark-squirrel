class GroupsController < ApplicationController
  include GroupAccessConcern

  def edit
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    @users_in_group = @group.users.order(name: :asc) if access_control(@group)
  end
end
