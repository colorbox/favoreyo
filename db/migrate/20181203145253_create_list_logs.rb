class CreateListLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :list_logs do |t|
      t.references :list
      t.references :tweet

      t.timestamps
    end
  end
end
