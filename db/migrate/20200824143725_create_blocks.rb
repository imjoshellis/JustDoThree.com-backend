class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks, id: :uuid do |t|
      t.string :title
      t.integer :kind
      t.string :block_list, default: ""
      t.string :task_list, default: ""
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
