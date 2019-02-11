class ApplicationController < ActionController::Base

  def set_user
    @user = User.find_by(twitter_uid: session[:twitter_uid])
  end
end
