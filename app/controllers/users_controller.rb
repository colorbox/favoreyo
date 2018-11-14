class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.where(timeline_published: true)
  end

  def destroy
    @user.destroy

    session[:token] = nil
    session[:token_secret] = nil
    session[:twitter_uid] = nil
    redirect_to root_path
  end

  def update
    @user.update!(user_params)
    redirect_to mypage_path
  end

  private

  def user_params
    params.require(:user).permit(:timeline_published, :favorite_threshold)
  end
end
