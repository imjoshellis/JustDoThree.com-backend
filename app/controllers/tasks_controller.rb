class TasksController < ApplicationController
  def index
    render json: TaskSerializer.new(Task.current_tasks).serialized_json
  end

  def overdue
    render json: TaskSerializer.new(Task.overdue).serialized_json
  end

  def create
    block = Block.find_by(block_id: params[:block_id])
    task = Task.create(title: params[:title], completed: false, dueDate: params[:dueDate], block_id: params[:block_id])
    block.task_list = block.task_list + "," + task.id

    render json: TaskSerializer.new(task).serialized_json
  end

  def update
    task = Task.find(params[:id])
    task.update(title: params[:title], completed: params[:completed], dueDate: params[:dueDate], block_id: params[:block_id])

    render json: TaskSerializer.new(task).serialized_json
  end

  def destroy
    task = Task.find(params[:id])
    task_json = TaskSerializer.new(task)
    task.destroy

    render json: task_json.serialized_json
  end
end
