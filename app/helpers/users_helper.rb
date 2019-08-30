module UsersHelper
  def manage_group_button(group, user)
    if group.owner_user_id == user.id
      link_to edit_group_path(group) do
        "<button id='btn_edit_bm_#{group.id}' 
          class='group_btn_edit' title='Manage this group'>Manage this group</button>".html_safe
      end
    else
      ''
    end
  end

  def group_ownership_text(group, user)
    if group.owner_user_id == user.id
      "* You own this group"
    else
      ""
    end
  end
end
