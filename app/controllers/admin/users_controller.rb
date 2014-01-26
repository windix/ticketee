class Admin::UsersController < Admin::BaseController
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

  private

  def user_params
    # set password confirmation since we don't require that from admin UI
    params[:user][:password_confirmation] = params[:user][:password]

    params.require('user').permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
