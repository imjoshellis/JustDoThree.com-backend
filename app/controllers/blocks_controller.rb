class BlocksController < ApplicationController
  def index
    Block.cleanup
    render json: BlockSerializer.new(Block.current_blocks).serialized_json
  end

  def update
    block = Block.find(params[:id])
    task = Task.find(params[:task_id])
    task.update(block_id: block.id)
    block.update(task_list: params[:task_list])

    render json: BlockSerializer.new(block).serialized_json
  end
end
