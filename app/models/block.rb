class Block < ApplicationRecord
  enum kind: [:life, :year, :quarter, :month, :week, :day]
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  validates :kind, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  def self.generate(year)
    title = "Y" + year.to_s
    b = Block.new(title: title, start_date: Date.new(year, 1, 1), end_date: Date.new(year, 12, 31))
    b.year!
    b.make_quarters
    life_block = Block.find_by(kind: 0)
    life_list = life_block.block_list
    if life_list
      life_list += "," + b.id
    else
      life_list = b.id
    end
    life_block.update(block_list: life_list)
    b
  end

end
