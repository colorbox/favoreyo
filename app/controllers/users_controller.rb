class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
  end

  def destroy
    @user.destroy

    session[:token] = nil
    session[:token_secret] = nil
    session[:twitter_uid] = nil
    redirect_to root_path
  end

  def update
    @user.update!(timeline_published: !@user.timeline_published)
  end
end
