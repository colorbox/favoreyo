class TweetsController < ApplicationController
  before_action :set_user

  def index
    @tweets = Tweet.order(id: :desc).limit(5)
    @tweets.where!('id < ?', params[:last]) if params[:last]

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
