class TweetsController < ApplicationController
  before_action :set_user

  def index
    selected_user = User.find_by_screen_name(params[:user_screen_name])
    @tweets = selected_user.tweets.order(id: :desc).limit(5)
    @tweets.where!('tweets.id < ?', params[:last]) if params[:last]

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_user
    @user = User.find_by_twitter_id(session[:twitter_id])
  end
end
