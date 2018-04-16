class RemoveTextColumnFromTweet < ActiveRecord::Migration[6.0]
  def change
    remove_column :tweets, :text
  end
end
