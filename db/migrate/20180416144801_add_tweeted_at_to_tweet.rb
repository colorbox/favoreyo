class AddTweetedAtToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :tweeted_at, :datetime
  end
end
