class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, :notice => 'User has been created.'
    else
      flash[:alert] = 'User has not been created.'
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated."
    else
      flash[:alert] = "User has not been updated."
      render "edit"
    end
  end

  def destroy
    if (@user == current_user)
      redirect_to admin_users_path, alert: "You cannot delete yourself!"
    else
      @user.destroy
      redirect_to admin_users_path, notice: "User has been deleted."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_users_path, alert: "The user you were looking for could not be found."
  end    

  def user_params
    if params[:user][:password].blank?
      # when updating user, do not update password if not set
      params[:user].delete(:password)
    else
      # set password confirmation since we don't require that from admin UI
      params[:user][:password_confirmation] = params[:user][:password]
    end

    params.require('user').permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
