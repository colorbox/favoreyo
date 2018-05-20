class FavoritesController < ApplicationController
  before_action :set_user
  before_action :set_tweet
  before_action :set_client

  def create
    @client.favorite!(@tweet.tweet_id)
    respond_to {|format| format.js }
  rescue Twitter::Error::AlreadyFavorited
    respond_to {|format| format.js }
  end

  def destroy
    @client.unfavorite!(@tweet.tweet_id)
    respond_to {|format| format.js }
  end

  private

  def favorite_params
    params.require(:tweet_id)
  end

  def set_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = @user.access_token
      config.access_token_secret = @user.access_token_secret
    end
  end

  def set_tweet
    @tweet = Tweet.find_by(id: favorite_params)
  end
end
