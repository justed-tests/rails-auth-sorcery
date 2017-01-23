# control them all
class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception

  def not_authenticated
    flash[:waring] = 'You have to authenticate to access this page'
    redirect_to :log_in
  end
end
