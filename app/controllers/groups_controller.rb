class GroupsController < ApplicationController
  include GroupAccessConcern

  def edit
    group_id = params[:id]
    @group = Group.find_by(id: group_id)
    if access_control(@group)
      # ...
    end
  end
end
