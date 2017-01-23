# sessions needs in control too
class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:email], params[:password])
      flash[:success] = 'Welcome back!'
      redirect_back_or_to root_path
    else
      flash[:error] = 'Something wrong with your credentials'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:sucess] = 'See you'
    redirect_to log_in_path
  end
end
