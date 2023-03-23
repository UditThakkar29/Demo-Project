class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @board = @project.board
    @sprints = @board.sprints
  end

  def show
    @project = Project.find(params[:project_id])
    @board = @project.board
  end
end
