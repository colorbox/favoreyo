namespace :tweet do
  desc 'fetch popular tweet from timeline'
  task fetch: :environment do
    User.all.each do |user|
      user.fetch_favorites_from_timeline
    end
  end

  TWEET_STORE_LIMIT = 1000
  desc 'remove old tweets in system'
  task remove: :environment do
    return if Tweet.count < TWEET_STORE_LIMIT

    Tweet.order(id: :asc).limit(Tweet.count/2).destroy_all
  end
end
