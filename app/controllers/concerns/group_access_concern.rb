module GroupAccessConcern
  extend ActiveSupport::Concern

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

      return true
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
end
