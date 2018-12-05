class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.references :user
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
