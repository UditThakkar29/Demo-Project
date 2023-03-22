class SprintsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @board = @project.board
  end

  def new
    @project = Project.find(params[:project_id])
    @board = @project.board
    @sprint = Sprint.new
  end

  def create
    @project = Project.find(params[:project_id])
    @board = @project.board
    @sprint = @board.sprints.create(sprint_params)

    if @sprint.save
      redirect_to project_board_sprint_path(id: @sprint)
    else
      render :new
    end
  end

  private
  def sprint_params
    params.require(:sprint).permit(:name,:start_time,:goal,:duration)
  end
end
