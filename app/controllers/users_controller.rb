class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_path, :notice => 'You have signed up successfully.'
    else
      flash[:alert] = 'Failed to sign up.'
      render "new"
    end

  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile has been updated."
    else
      flash[:alert] = "User has not been updated."
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])    
  end

  def user_params
    params.require('user').permit(:name, :email, :password, :password_confirmation)
  end
end
