class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.id == current_user.id && @user.update(params.require(:user).permit(user_params))
      redirect_to action: :profile
    else
      redirect_to action: :profile
    end
  end

  private
  def user_params
    params.require(:reservation).permit(:image, :username, :profile)
  end
end
