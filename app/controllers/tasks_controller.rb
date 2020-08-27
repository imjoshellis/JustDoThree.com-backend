class TasksController < ApplicationController
  def index
    render json: TaskSerializer.new(Task.current_tasks).serialized_json
  end

  def overdue
    render json: TaskSerializer.new(Task.overdue).serialized_json
  end

  def create
    puts params
    block = Block.find(params[:block_id])
    task = Task.create(title: params[:title], completed: false, block_id: params[:block_id])
    block.task_list = block.task_list.length > 0 ? block.task_list + "," + task.id : task.id
    block.save

    render json: TaskSerializer.new(task).serialized_json
  end

  def update
    task = Task.find(params[:id])
    task.update(title: params[:title], completed: params[:completed], due_date: params[:due_date], block_id: params[:block_id])

    render json: TaskSerializer.new(task).serialized_json
  end

  def destroy
    task = Task.find(params[:id])
    block = Block.find(task.block_id)
    task_json = TaskSerializer.new(task)
    task.destroy
    new_task_list = block.task_list.split(",").select { |id| id != params[:id] }
    new_task_list.join(",") unless block.tasks.count === 0
    block.update(task_list: new_task_list)

    render json: task_json.serialized_json
  end
end
