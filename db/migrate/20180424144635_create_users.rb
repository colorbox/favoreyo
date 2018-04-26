class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :screen_name, null: false
      t.string :twitter_id, null: false
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end
end
