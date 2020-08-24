class BlocksController < ApplicationController
  def index
    blocks = Block.current_blocks

    render json: BlockSerializer.new(blocks).to_serialized_json
  end

  def update
    block = Block.find_by(id: params[:id])
    block.update(task_list: params[:task_list])

    render json: BlockSerializer.new(block).to_serialized_json
  end
end
