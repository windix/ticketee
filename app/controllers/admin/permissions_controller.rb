class Admin::PermissionsController < Admin::BaseController
  before_action :set_user

  def index
    @ability = Ability.new(@user)
    @projects = Project.all
  end

  def set
    @user.permissions.clear

    params[:permissions].each do |id, permissions|
      project = Project.find(id)
      permissions.each do |permission, checked|
        Permission.create!(user: @user, thing: project, action: permission)
      end
    end

    redirect_to admin_user_permissions_path, alert: "Permissions updated."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_users_path, alert: "The user you were looking for could not be found."
  end   
end
