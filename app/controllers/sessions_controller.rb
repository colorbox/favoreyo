class SessionsController < ApplicationController
  protect_from_forgery

  FAVORITE_COUNT = 50
  TWEET_FETCH_LIMIT = 200
  # timeline API limit
  FETCHING_COUNT_LIMIT = 4

  def new
    auth = request.env["omniauth.auth"]
    user = User.find_or_initialize_by(twitter_uid: auth.uid)
    user.update!(
      screen_name: auth.info.nickname,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
    )
    session[:token] = auth.credentials.token
    session[:token_secret] = auth.credentials.secret
    session[:twitter_uid] = auth.uid
    if user.tweets.count.zero?
      last_tweet = nil
      FETCHING_COUNT_LIMIT.times do
        params = {count: TWEET_FETCH_LIMIT}
        params[:max_id] = last_tweet.tweet_id if last_tweet

        client(user).home_timeline(params).each do |fetched_tweet|
          fetched = user.tweets.map(&:tweet_id).include?(fetched_tweet.id.to_s)
          next if fetched || user.tweets.find_by(tweet_id: fetched_tweet.id) || fetched_tweet.favorite_count < FAVORITE_COUNT
          tweet = Tweet.find_by(tweet_id: fetched_tweet.id)

          if tweet.nil?
            tweet = user.tweets.build(tweet_id: fetched_tweet.id)
          else
            user.tweets << tweet
          end
          tweet.favorite_count = fetched_tweet.favorite_count
          last_tweet = tweet
        end
      end
      user.save!
    end
    redirect_to root_path
  end

  def destroy
    session[:token] = nil
    session[:token_secret] = nil
    session[:twitter_uid] = nil
    redirect_to root_path
  end

  private

  def client(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = user.access_token
      config.access_token_secret = user.access_token_secret
    end
  end
end
