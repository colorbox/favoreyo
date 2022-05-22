class Deliverer < ApplicationRecord
  belongs_to :user

  validate :name, :presence

  def deliver_tweet(tweet)
    bot = Discordrb::Bot.new token: discord_token
    bot.send_message(discord_channel_identifier, 'https://twitter.com/i/web/status/' + tweet.tweet_id)
  end
end
