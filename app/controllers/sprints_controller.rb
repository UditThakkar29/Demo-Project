# frozen_string_literal: true

# Model to store all Sprints.
class SprintsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug, only: %i[show new create end_sprint backlog_tickets]
  before_action :new_sprint_is_present, only: %i[end_sprint]
  # def index
  #   @project = Project.friendly.find_by_slug(params[:project_slug])
  #   @board = @project.board
  #   @sprints = Sprint.all
  # end

  def show
    @sprint = Sprint.friendly.find_by_slug(params[:slug])
    return unless @sprint.nil?

    raise ActiveRecord::RecordNotFound
  end

  def new
    @sprint = Sprint.new
  end

  def create
    @sprint = @board.sprints.create(sprint_params)

    if @sprint.save
      redirect_to project_board_sprint_path(slug: @sprint)
    else
      render :new
    end
  end

  def end_sprint
    
    redirect_to project_board_sprint_path(slug: params[:slug])
  end

  def backlog_tickets
    @sprint = Sprint.friendly.find_by_slug(params[:slug])
  end

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:project_slug])
    @board = @project.board
  end

  def sprint_params
    params.require(:sprint).permit(:name, :start_time, :goal, :duration)
  end

  def new_sprint_is_present
    redirect_to project_board_sprint_path(slug: params[:slug]), alert: "No sprint to transfer tickets to"
  end
end
