class BlockSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :kind, :block_list, :task_list, :start_date, :end_date
end
