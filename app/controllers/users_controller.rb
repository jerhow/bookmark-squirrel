class UsersController < ApplicationController
  def show
  end

  def groups
    @groups = current_user.groups
  end
end
