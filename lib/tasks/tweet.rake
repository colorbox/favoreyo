namespace :tweet do

  desc "fetch popular tweet from timeline"
  task fetch: :environment do
    FAVORITE_COUNT = 50

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    last_tweet = nil
    4.times do
      params = {count: 200}
      params[:max_id] = last_tweet.tweet_id if last_tweet
      fetched_tweets = []

      client.home_timeline(params).each do |fetched_tweet|
        next if fetched_tweet.favorite_count < FAVORITE_COUNT
        tweet = Tweet.find_or_initialize_by(tweet_id: fetched_tweet.id)
        tweet.favorite_count = fetched_tweet.favorite_count
        fetched_tweets << tweet
        last_tweet = tweet
      end
      fetched_tweets.reverse.each(&:save)
    end
  end

  desc "remove old tweets in system"
  task remove: :environment do
    return if Tweet.count < 5

    Tweet.order(id: :asc).limit(Tweet.count/2).delete_all
  end
end
