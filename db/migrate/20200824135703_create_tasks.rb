class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.boolean :completed
      t.string :dueDate
      t.string :block_id

      t.timestamps
    end
  end
end
