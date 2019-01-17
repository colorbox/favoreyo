class TwitterClient
  def self.client(access_token, access_token_secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
