class Block < ApplicationRecord
  has_many :tasks, dependent: :destroy
end
