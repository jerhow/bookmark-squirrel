module BookmarksHelper

  ##
  # 'group_select_tag_helper' returns an array of arrays representing the data format 
  # needed by 'options_for_select' (found under ActionView::Helpers::FormOptionsHelper)
  # An example of the necessary format would be:
  # [ ["Value 1", "1"], ["Value 2", "2"] ]
  # REF: https://apidock.com/rails/ActionView/Helpers/FormOptionsHelper/options_for_select

  def group_select_tag_helper(user_id)
    groups = User.find_by(id: user_id).groups.order(title: :asc)
    option_value_pairs = []
    
    groups.each do |g|
      option_value_pairs.push([ g['title'], g['id'] ])
    end

    option_value_pairs
  end
end
