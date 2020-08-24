class Task < ApplicationRecord
  belongs_to :block
  validates :title, presence: true
  validates :block_id, presence: true

  def self.current_tasks
    tasks = []

    Block.current_blocks.each do |b|
      b.tasks.each do |t|
        tasks << t
      end
    end

    tasks
  end

  def self.overdue
    tasks = []

    Block.where("end_date < ?", Date.today).each do |b|
      b.tasks.each do |t|
        tasks << t if t.completed === false
      end
    end

    tasks
  end

  def block_title
    Block.find(block_id).title
  end
end
