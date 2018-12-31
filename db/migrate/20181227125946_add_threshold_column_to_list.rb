class AddThresholdColumnToList < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :lists_threshold, :integer, default: 50, null: false
  end
end
