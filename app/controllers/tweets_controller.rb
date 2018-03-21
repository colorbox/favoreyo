class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    @earlier_tweets = tweets[0..5]
    @later_tweets = tweets - @earlier_tweets
  end

  def show
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
