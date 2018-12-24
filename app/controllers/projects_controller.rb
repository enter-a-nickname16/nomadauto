class ProjectsController < ApplicationController
skip_before_filter :verify_authenticity_token, only: [:index, :show]

  def index
    # GET request for which / is our home page
    # @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
    # @invite_plan = Plan.find(3)
    if Project.exists?(user: current_account)
      @projects = current_account.user_projects
    end

  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def new
    @project = Project.new
    #@task = Task.new(project_id: params[:project_id])
  end

  def create
    @project = current_account.projects.build(project_params)
     if @project.save
       flash[:notice] = "#{@project.title} is processing."
       redirect_to projects_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :details, :task_id, :deal_id)
  end
end
