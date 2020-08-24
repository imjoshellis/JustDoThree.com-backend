class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks do |t|
      t.string :uuid
      t.string :title
      t.string :type
      t.string :block_list
      t.string :task_list
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
