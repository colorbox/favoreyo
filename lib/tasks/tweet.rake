namespace :tweet do

  desc "fetch popular tweet from timeline"
  task fetch: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    client.home_timeline(count: 200).each do |tweet|
      Tweet.create(tweet_id: tweet.id)
    end
  end
end
