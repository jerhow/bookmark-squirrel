module UsersHelper
  def manage_group_button(user, group)
    if group.owner_user_id == current_user.id
      link_to edit_group_path(group) do
        "<button id='btn_edit_bm_#{group.id}' 
          class='group_btn_edit' title='Manage this group'>Manage this group</button>".html_safe
      end
    else
      ''
    end
  end
end
