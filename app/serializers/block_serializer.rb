class BlockSerializer
  def initialize(o)
    @block = o
  end

  def to_serialized_json
    options = {
      include: {
        tasks: {
          only: [:id, :title, :completed, :due_date, :block_id]
        }
      },
      only: [:id, :title, :type, :block_list, :task_list]
    }
    @block.to_json(options)
  end
end
