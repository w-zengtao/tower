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
      ary = params[:todo][:deadline].split('/') # 那个gem 有点问题 也许会准备fork改一下 暂时先这样处理一下
      ary = [ary[2], ary[0], ary[1]].join('-')
      @deadline = ary.to_date
      act = params[:act].to_i
      if @todo && (0 != act)
        @todo.update_attribute('state', act)
      end
      if @todo && @deadline
        @todo.update(deadline: @deadline, state: 6)
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
