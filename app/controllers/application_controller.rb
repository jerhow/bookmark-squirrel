class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :demo_user_no_editing, if: :devise_controller?

  def after_sign_in_path_for(users)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  def demo_user_no_editing
    if (params["action"] == "edit" || params["action"] == "update") && current_user.demo?
      flash[:notice] = "This profile belongs to a demo account and cannot be edited."
      redirect_to show_user_path
    end
  end
end
