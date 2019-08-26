class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if !current_user.nil?
      groups = current_user.groups
      @group_ownership_count = groups.where('owner_user_id = ?', current_user.id).count
      @group_membership_count = groups.where('owner_user_id <> ?', current_user.id).count
    end
  end
end
