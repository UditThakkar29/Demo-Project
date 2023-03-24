class ProjectsController < ApplicationController
  before_action :authenticate_user!
  def index
    @projects = Project.all
  end

  def show
    puts "////////////////////////"
    @project = current_user.projects.find(params[:id])
    # @project = Project.find(params[:id])

    # users = project.users
    # users.each do |user|
    #   if current_user.id == user.id
    #     puts "////////////////////////"
    #     puts current_user.id
    #     puts "////////////////////////"
    #     @project = project
    #   end
    # end


  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
