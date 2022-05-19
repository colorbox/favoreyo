namespace :deliverer do
  desc 'deliver yesterday tweets'
  task deliver_yesterday_tweets: :environment do
    Deliverer.all.each do |deliverer|
      deliverer.user.tweets.where!('Date(tweets.created_at) = :date', date: Date.yesterday).each do |tweet|
        sleep(0.05)
        deliverer.deliver_tweet(tweet)
      end
    end
  end
end
