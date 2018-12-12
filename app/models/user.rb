class User < ApplicationRecord
  has_many :timeline_logs, dependent: :destroy
  has_many :tweets, through: :timeline_logs
  has_many :lists, dependent: :destroy

  TWEET_FETCH_LIMIT = 200
  # timeline API limit
  FETCHING_COUNT_LIMIT = 4

  def fetch_favorites_from_timeline
    last_tweet = nil
    client = TwitterClient.build_client(access_token, access_token_secret)
    FETCHING_COUNT_LIMIT.times do
      params = {count: TWEET_FETCH_LIMIT}
      params[:max_id] = last_tweet.tweet_id if last_tweet

      last_tweet = save_tweets(client.home_timeline(params))
    end
  rescue Twitter::Error::TooManyRequests => e
    raise e
  end

  def fetch_lists
    client = TwitterClient.build_client(access_token, access_token_secret)
    # 1000 lists is enough for one user
    save_lists(client.owned_lists(count: 1000))
  end

  private

  def save_lists(fetched_lists)
    fetched_lists.each do |fetched_list|
      next if lists.map(&:list_identifier).include?(fetched_list.id)
      lists.create(list_identifier: fetched_list.id, name: fetched_list.name)
    end
  end

  def save_tweets(fethed_tweets)
    last_tweet = nil
    fethed_tweets.each do |fetched_tweet|
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
    last_tweet
  end
end
