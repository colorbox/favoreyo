class AddTimelinePublishedFlagToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :timeline_published, :boolean, default: false, null: false
  end
end
