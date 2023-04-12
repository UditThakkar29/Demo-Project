class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_by_slug, only: %i[show edit update destroy remove_users report]
  before_action :check_subsciption, only: %i[report]
  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    #   authorize! :create, @project
  end

  def create
    @project = current_user.projects.create(project_params) if current_user.has_role? (:manager)

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
    # redirect_to projects_path
  end


  def remove_users
    # @project
    id = params[:user]
    @project.users.delete(User.find(id))
    redirect_to @project
  end

  def invite_user
    # @value = new_project_invitation_url(@project)
    @project = current_user.projects.friendly.find_by_slug(params[:slug])
    @email = params[:user][:email]
    # debugger
    mail = ProjectMailer.invite_email(email: @email, project: @project).deliver_now
    # mail
    redirect_to @project, notice: 'Email Sent'
  end

  def report
    # redirect_to @project
  end

  private

  def check_subsciption
    # debugger
    unless current_user.active_subscription?
      redirect_to checkout_show_path, alert: "You don't have a subscription or you subscription expired."
    end
  end

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
