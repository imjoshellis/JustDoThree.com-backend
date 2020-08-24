class Task < ApplicationRecord
  belongs_to :block
  validates :title, presence: true
  validates :block_id, presence: true
end
