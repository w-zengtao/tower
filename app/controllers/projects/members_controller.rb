module Projects
  class MembersController < ::BaseController

    def index
      @project = Project.find_by(id: params[:project_id])
    end

    def create
    end

  end
end
