class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :uuid
      t.string :title
      t.boolean :completed
      t.string :dueDate
      t.string :block_uuid
      t.integer :block_id

      t.timestamps
    end
  end
end
