class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_user
    @user = User.find_by(twitter_uid: session[:twitter_uid])
  end
end
