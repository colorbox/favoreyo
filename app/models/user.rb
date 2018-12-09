class User < ApplicationRecord
  has_many :timeline_logs, dependent: :destroy
  has_many :tweets, through: :timeline_logs

  TWEET_FETCH_LIMIT = 200
  # timeline API limit
  FETCHING_COUNT_LIMIT = 4

  def fetch_favorites_from_timeline
    last_tweet = nil
    FETCHING_COUNT_LIMIT.times do
      params = {count: TWEET_FETCH_LIMIT}
      params[:max_id] = last_tweet.tweet_id if last_tweet
      client = TwitterClient.build_client(access_token, access_token_secret)

      client.home_timeline(params).each do |fetched_tweet|
        fetched = tweets.map(&:tweet_id).include?(fetched_tweet.id.to_s)
        next if fetched || fetched_tweet.favorite_count < self.favorite_threshold || tweets.find_by(tweet_id: fetched_tweet.id)
        tweet = Tweet.find_by(tweet_id: fetched_tweet.id)
        if tweet.nil?
          tweet = self.tweets.create(tweet_id: fetched_tweet.id, favorite_count: fetched_tweet.favorite_count)
        else
          self.tweets << tweet
          save!
        end

        last_tweet = tweet
      end
    end
  rescue Twitter::Error::TooManyRequests => e
    raise e
  end
end
