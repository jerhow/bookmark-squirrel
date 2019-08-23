class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @group_count = current_user.groups.count if !current_user.nil?
  end
end
