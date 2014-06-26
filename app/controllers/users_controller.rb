class UsersController < ApplicationController

  before_action :ensure_current_user, except: [:new, :create]

  respond_to :html, :json

  def show
    @user = current_user
    respond_with @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_params)
    @user.save
    respond_with @user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(safe_params)
    redirect_to user_url(@user)
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to users_url
  end


  private

  def safe_params
    safe_attributes = [
      :name,
      :email,
      :password,
      :password_confirmation
    ]
    params.require(:user).permit(*safe_attributes)
  end

  def ensure_current_user
    redirect_to new_session_url unless logged_in?
  end

end



















