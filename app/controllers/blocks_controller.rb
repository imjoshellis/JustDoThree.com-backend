class BlocksController < ApplicationController
  def index
    render json: BlockSerializer.new(Block.current_blocks).serialized_json
  end

  def update
    block = Block.find(params[:id])
    block.update(task_list: params[:task_list])

    render json: BlockSerializer.new(block).serialized_json
  end
end
