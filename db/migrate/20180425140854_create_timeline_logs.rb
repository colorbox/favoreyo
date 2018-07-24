class CreateTimelineLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :timeline_logs do |t|
      t.references :user
      t.references :tweet

      t.timestamps
    end
  end
end
