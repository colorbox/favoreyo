class AddFavoriteThresholdColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite_threshold, :integer, default: 50, null: false
  end
end
