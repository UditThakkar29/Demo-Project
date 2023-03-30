class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug, only: [:show,:edit,:update,:destroy,:remove_users]
  def index
    @projects = Project.all
  end

  def show
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
  end

  def update
    @project_test = Project.new(project_params)
    if @project_test.valid?
      @project.slug = nil if @project.name != params[:name]
      @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
    # if @project.update(project_params)
    #   redirect_to @project
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def remove_users
    # @project
    id = params[:user]
    @project.users.delete(User.find(id))
    redirect_to @project
  end

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:slug])
    if @project==nil
      raise ActiveRecord::RecordNotFound
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
