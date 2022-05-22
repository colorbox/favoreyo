class CreateDeliverers < ActiveRecord::Migration[6.1]
  def change
    create_table :deliverers do |t|
      t.references :user

      t.string :name, null: false
      t.string :discord_token, null: false
      t.string :discord_channel_identifier, null: false

      t.timestamps
    end
  end
end
