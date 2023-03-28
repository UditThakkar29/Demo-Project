class SprintsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug, only: [:show,:new,:create]
  # def index
  #   @project = Project.friendly.find_by_slug(params[:project_slug])
  #   @board = @project.board
  #   @sprints = Sprint.all
  # end

  def show
    @sprint = Sprint.friendly.find_by_slug(params[:slug])
    if @sprint==nil
      raise ActiveRecord::RecordNotFound
    end
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

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:project_slug])
    @board = @project.board
  end

  def sprint_params
    params.require(:sprint).permit(:name,:start_time,:goal,:duration)
  end
end
