class PagesController < ApplicationController
  def home
    @group_count = current_user.groups.count
  end
end
