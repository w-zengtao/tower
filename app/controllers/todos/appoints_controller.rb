module Todos
  class AppointsController < ::BaseController
    before_action :set_todo_and_user

    def create
      act = 3 # 指派了
      if @todo.user
        act = 5 # 重新指派了
      end
      if @todo.update(user: @user, state: act)
        respond_to do |format|
          format.js
        end
      end
    end

    private
    def set_todo_and_user
      @todo = Todo.find_by(id: params[:todo_id])
      @user = User.find_by(id: params[:appoint][:user])
    end
  end
end
