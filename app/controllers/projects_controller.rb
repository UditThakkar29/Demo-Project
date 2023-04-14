# frozen_string_literal: true

# Controller for handling all the action related to the project model
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :find_by_slug, except: %i[index new create]
  before_action :check_subsciption, only: %i[report]

  def index
    @projects = Project.all
  end

  def show; end


  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params) if current_user.has_role? (:manager)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.board.sprints.each do |s|
      # s.tickets.each { |t| t.destroy }
      s.tickets.each(&:destroy)
    end
    @project.destroy
  end

  def remove_users
    id = params[:user]
    @project.users.delete(User.find(id))
    redirect_to @project
  end

  def invite_user
    @email = params[:user][:email]
    # debugger
    ProjectMailer.invite_email(email: @email, project: @project).deliver_now
    redirect_to @project, notice: 'Email Sent'
  end

  def report
    @sprints = @project.board.sprints.where(backlog_sprint: nil)
    @data = {}
    @data1 = {}
    @sprints.each do |s|
      @data[s.name] = s.total_story_points
      @data1[s.name] = s.completed_story_points
    end
  end

  def cancel_subscription
    subscription_key = current_user.subscription.subscription_key
    @stripe_subscription = Stripe::Subscription.retrieve(subscription_key)
    # debugger
    Stripe::Subscription.cancel(@stripe_subscription.id)
    current_user.subscription.update(subscription_status: 'canceled')
    redirect_to @project
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
    raise ActiveRecord::RecordNotFound if @project.nil?
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
