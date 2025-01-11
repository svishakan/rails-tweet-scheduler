class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  def set_current_user
    # Render app/views/main/index.html.erb
    if session[:user_id]
      # If the user is logged in, look the user up
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def require_user_logged_in!
    # If the user is not logged in, redirect to sign in page
    redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
  end
end
