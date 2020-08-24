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

  def make_quarters
    block_list = ""
    4.times do |i|
      title = "Q" + (i + 1).to_s
      q_start = Date.new(start_date.year, i * 3 + 1, 1)
      b = Block.new(title: title, start_date: q_start, end_date: q_start.end_of_quarter)
      b.quarter!
      b.make_months

      block_list += if i === 0
        b.id
      else
        "," + b.id
      end
      update(block_list: block_list)
    end
  end

  def make_months
    block_list = ""
    3.times do |i|
      m_start = Date.new(start_date.year, i + start_date.month, 1)
      title = m_start.strftime("%b")
      b = Block.new(title: title, start_date: m_start, end_date: m_start.end_of_month)
      b.month!
      b.make_days

      block_list += if i === 0
        b.id
      else
        "," + b.id
      end
    end
    save
  end

  def make_days
    block_list = ""
    start_date.end_of_month.day.times do |i|
      d_start = Date.new(start_date.year, start_date.month, i + 1)
      title = d_start.strftime("%b %-d (%a)")
      b = Block.new(title: title, start_date: d_start, end_date: d_start)
      b.day!

      block_list += if i === 0
        b.id
      else
        "," + b.id
      end

    end
    save
  end
end
