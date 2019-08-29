class UsersController < ApplicationController
  def show
    @is_admin = current_user.admin?
  end

  def groups
    @groups = current_user.groups.order(created_at: :asc)
    @group_user_counts = get_group_user_counts
  end

  def delete_avatar
    user = User.find_by(id: params[:user_id])
    current_user.avatar.purge if user.id == current_user.id

    respond_to do |format|
      flash[:success] = "Profile image was successfully deleted"
      format.html { redirect_to edit_user_registration_path }
    end
  end

  private

    def get_group_user_counts
      sql = "SELECT gu.group_id, COUNT(gu.user_id) AS user_count " +
          "FROM groups_users gu WHERE gu.group_id IN " +
          "( SELECT group_id FROM groups_users WHERE user_id = #{current_user.id} ) " +
          "GROUP BY gu.group_id ORDER BY gu.group_id"

      counts = ActiveRecord::Base.connection.exec_query(sql)
      group_user_counts = {}

      counts.each do |c|
        group_user_counts[ c['group_id'] ] = c['user_count']
      end

      group_user_counts
    end

end
