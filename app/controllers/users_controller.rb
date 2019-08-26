class UsersController < ApplicationController
  def show
    @is_admin = current_user.admin?
  end

  def groups
    @groups = current_user.groups.order(created_at: :asc)
  end

  def delete_avatar
    user = User.find_by(id: params[:user_id])
    current_user.avatar.purge if user.id == current_user.id

    respond_to do |format|
      flash[:success] = "Profile image was successfully deleted"
      format.html { redirect_to edit_user_registration_path }
    end
  end
end
