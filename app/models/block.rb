class Block < ApplicationRecord
  enum kind: [:life, :year, :quarter, :month, :week, :day]
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  validates :kind, presence: true

  def self.current_blocks
    # initialize blocks array
    blocks = []

    # get current date
    today = Date.today

    # try to find life block
    life_block = Block.find_by(kind: 0)

    # if it doesn't exist, make it
    unless life_block
      life_block = Block.new(title: "Life")
      life_block.life!
    end

    # push into blocks array
    blocks << life_block

    # try to find the year
    year_block = Block.where(kind: "year").find_by(start_date: today.beginning_of_year)

    # if it doesn't exist, generate the year
    year_block ||= Block.generate(today.year)

    # push into blocks array
    blocks << year_block

    # find and add quarter
    blocks << Block.where(kind: "quarter").find_by(start_date: today.beginning_of_quarter)

    # find and add month
    blocks << Block.where(kind: "month").find_by(start_date: today.beginning_of_month)

    # find and add next 10 days
    10.times do |i|
      day_block = Block.where(kind: "day").find_by(start_date: today + i)

      # if day doesn't exist, generate next year
      unless day_block
        Block.generate(today.year + 1)
        day_block = Block.where(kind: "day").find_by(start_date: today + i)
      end

      blocks << day_block
    end

    blocks
  end

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

      Task.create(title: title, block_id: b.id)
    end
    save
  end
end
