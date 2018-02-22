class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :tweet_id, null: false
      t.integer :favorite_count, null: false

      t.timestamps

      t.index :tweet_id, unique: true
    end
  end
end
