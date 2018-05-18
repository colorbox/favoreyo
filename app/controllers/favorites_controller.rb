class FavoritesController < ApplicationController
  before_action :set_user
  before_action :set_client

  def create
    debugger
    tweet = Tweet.find_by(id: favorite_params)
    @client.favorite!(tweet.tweet_id)

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
end
