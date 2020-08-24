class Task < ApplicationRecord
  belongs_to :block
  validates :title, presence: true
  validates :block_id, presence: true

  def block_title
    Block.find(block_id).title
  end
end
