class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
  end

  def set_user
    @user = User.find_by(twitter_uid: session[:twitter_uid])
  end
end
