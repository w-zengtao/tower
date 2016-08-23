class CommentJob < ApplicationJob
  queue_as :callbacks

  def perform(operator_id, user_id, klass, obj_id, act)
    @obj = klass.constantize.find_by(id: obj_id) # comment
    @todo = @obj.todo
    if @obj && @todo
      @event = @obj.events.create(operator_id: operator_id, act: act, user_id: user_id, project: @todo.project)
    end
  end
end
