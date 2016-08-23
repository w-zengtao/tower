module Projects
  class TodosController < BaseController

    before_action :set_project, only: [:new, :create, :update]

    def new
      @todo = @project.todos.build
    end

    def show
      @todo = Todo.find_by(id: params[:id])
      @comments = @todo.total_comments.includes(:user)
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

    def destroy
      @todo = Todo.find_by(id: params[:id])
      if @todo.destroy
        respond_to do |format|
          format.js
        end
      end
    end

    def update
      @todo = Todo.find_by(id: params[:id])
      act = params[:act].to_i
      if @todo && act
        @todo.update_attribute('state', act)
      end
      respond_to do |format|
        format.js
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
end
