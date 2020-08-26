class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :due_date, :block_id, :block_title, :completed
end
