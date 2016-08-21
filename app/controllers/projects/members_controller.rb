module Projects
  class MembersController < ::BaseController

    def index
      @project = Project.includes(:accesses, :members).find_by(id: params[:project_id])
      @members = @project.members
    end

    def create
      @new_member = User.find_by(id: params[:access][:member])
      @project = Project.find_by(id: params[:project_id])
      if @new_member && @project
        @access = @project.add_member(@new_member)
        if @access
          respond_to do |format|
            format.js
          end
        end
      end

    end

  end
end
