class PagesController < ApplicationController
  def home
    @group_count = current_user.groups.count if !current_user.nil?
  end
end
