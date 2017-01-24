# control your users
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new, :activate]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Welcome!'
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path
    else
      render 'new'
    end
  end

  def activate
    @user = User.load_from_activation_token(params[:id])

    if @user
      @user.activate!
      flash[:success] = 'User was successfully activated'
      redirect_to log_in_path
    else
      flash[:warning] = 'Cannot activate this user'
      redirect_to root_path
    end
  end

  # not tested & mailer didn't exist
  def unlock
    @user = User.load_from_unlock_token(params[:token])
    @user.unlock!
    flash[:success] = 'Account was successfully unlocked'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation, :name)
  end
end
