module Projects
  class MembersController < ::BaseController

    def index
      @project = Project.find_by(id: params[:project_id])
      @members = @project.valid_members
    end

    def create
      @new_member = User.find_by(id: params[:access][:member])
      @project = Project.find_by(id: params[:project_id])
      if @new_member && @project
        @access = @project.accesses.find_by(user_id: @new_member.id)
        @access.update_attribute('status', 1) if @access
        @access = @project.add_member(@new_member) unless @access
        if @access
          respond_to do |format|
            format.js
          end
        end
      end
    end

    def destroy
      @access = Access.find_by(project_id: params[:project_id], user_id: params[:id])
      @access.update_attribute('status', 0)
      if 0 == @access.level
        respond_to do |format|
          format.js
        end
      end
    end

  end
end
