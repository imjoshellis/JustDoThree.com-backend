class TaskSerializer
  def initialize(o)
    @task = o
  end

  def to_serialized_json
    options = {
      only: [:id, :title, :dueDate, :block_id]
    }
    @task.to_json(options)
  end
end
