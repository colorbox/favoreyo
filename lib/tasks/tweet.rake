namespace :tweet do

  desc "fetch popular tweet from timeline"
  task fetch: :environment do
    FAVORITE_COUNT = 50

    User.all.each do |user|
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.access_token = user.access_token
        config.access_token_secret = user.access_token_secret
      end

      last_tweet = nil
      4.times do
        params = {count: 200}
        params[:max_id] = last_tweet.tweet_id if last_tweet
        fetched_tweets = []

        client.home_timeline(params).each do |fetched_tweet|
          next if user.tweets.find_by(tweet_id: fetched_tweet.id) || fetched_tweet.favorite_count < FAVORITE_COUNT
          tweet = user.tweets.build(tweet_id: fetched_tweet.id)
          tweet.favorite_count = fetched_tweet.favorite_count
          fetched_tweets << tweet
          last_tweet = tweet
        end
        user.tweets.append(fetched_tweets.reverse)
        user.save
      end
    end
  end

  desc "remove old tweets in system"
  task remove: :environment do
    return if Tweet.count < 1000

    Tweet.order(id: :asc).limit(Tweet.count/2).delete_all
  end
end
