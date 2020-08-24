class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :dueDate, :block_id, :block_title
end
