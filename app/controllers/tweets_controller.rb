class TweetsController < ApplicationController
  before_action :set_request_variant
  before_action :set_user

  def index
    selected_user = User.find_by(screen_name: params[:user_screen_name])

    redirect_to root_path if !selected_user.timeline_published && @user&.id != selected_user.id

    @tweets = selected_user.tweets.order(id: :desc).limit(5)
    @tweets.where!('tweets.id < ?', params[:last]) if params[:last]

    if params[:date]
      date = Date.parse(params[:date])
      @tweets.where!('Date(tweets.created_at) = :date', date: date)
    end

    respond_to :html, :'html.smartphone', :js
  end

  private

  def set_request_variant
    request.variant = request.device_variant # :pc, :smartphone
  end
end
