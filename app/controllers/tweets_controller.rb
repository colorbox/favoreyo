class TweetsController < ApplicationController
  before_action :set_user

  def index
    selected_user = User.find_by(screen_name: params[:user_screen_name])

    redirect_to root_path unless selected_user.timeline_published || @user&.id != selected_user.id

    @tweets = selected_user.tweets.order(id: :desc).limit(5)
    @tweets.where!('tweets.id < ?', params[:last]) if params[:last]

    respond_to do |format|
      format.html
      format.js
    end
  end
end
