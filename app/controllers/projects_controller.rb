class ProjectsController < ApplicationController

  def index
    @projects = Project.all 
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end
  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
