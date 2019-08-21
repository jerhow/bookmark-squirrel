module ApplicationHelper
  def login_helper(style = "")
    if current_user # Is there a user? Will be nil otherwise.
      @is_user = current_user.is_a?(User)
      @is_admin = current_user.admin?
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    else
      (link_to "Login", new_user_session_path, class: style) + 
        " or ".html_safe +
        (link_to "Register", new_user_registration_path, class: style)
    end
  end

  def user_avatar(user, size=50)
    if user.avatar.attached?
      user.avatar.variant(combine_options: {resize: "#{size}x#{size}!"})
    else
      user.profile_image
    end
  end
end
