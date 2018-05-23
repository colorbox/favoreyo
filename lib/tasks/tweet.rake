namespace :tweet do

  desc "fetch popular tweet from timeline"
  task fetch: :environment do
    FAVORITE_COUNT = 50
    TWEET_FETCH_LIMIT = 200
    # timeline API limit
    FETCHING_COUNT_LIMIT = 4

    User.all.each do |user|
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.access_token = user.access_token
        config.access_token_secret = user.access_token_secret
      end

      last_tweet = nil
      FETCHING_COUNT_LIMIT.times do
        params = {count: TWEET_FETCH_LIMIT}
        params[:max_id] = last_tweet.tweet_id if last_tweet

        client.home_timeline(params).each do |fetched_tweet|
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
  end

  TWEET_STORE_LIMIT = 1000
  desc "remove old tweets in system"
  task remove: :environment do
    return if Tweet.count < TWEET_STORE_LIMIT

    Tweet.order(id: :asc).limit(Tweet.count/2).destroy_all
  end
end
