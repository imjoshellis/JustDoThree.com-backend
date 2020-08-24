class Block < ApplicationRecord
  enum kind: [:life, :year, :quarter, :month, :week, :day]
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  validates :kind, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
