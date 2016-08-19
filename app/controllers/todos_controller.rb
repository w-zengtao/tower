class TodosController < BaseController

  before_action :set_project, only: [:new, :create]

  def new
    @todo = @project.todos.build
  end

  def create
    @todo = @project.todos.build(todo_params)
    if @todo.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end
  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def todo_params
    params.require(:todo).permit(:name, :user_id, :state)
  end
end
