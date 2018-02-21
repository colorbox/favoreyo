class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :tweet_id

      t.timestamps

      t.index :tweet_id, unique: true
    end
  end
end
