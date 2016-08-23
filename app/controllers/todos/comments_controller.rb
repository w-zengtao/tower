module Todos
  class CommentsController < ::BaseController
    before_action :set_todo

    def create
      @comment = @todo.comments.create(comment_params.merge({ 'user': current_user, 'todo_id': @todo.id }))
      if @comment
        respond_to do |format|
          format.js
        end
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_todo
      @todo = Todo.find_by(id: params[:todo_id])
    end
  end
end
