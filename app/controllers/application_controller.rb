class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin!
    unless current_user
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to signin_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_only(&block)
    block.call if current_user.try(:admin?)
  end

  def authorize_admin!
    require_signin!

    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end

  helper_method :require_signin!, :current_user, :admin_only
end
