class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order('id DESC').limit(5)
    @tweets.where!('id < ?', params[:last]) if params[:last]

    respond_to do |format|
      format.html
      format.js
    end
  end
end
