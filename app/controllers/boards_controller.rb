class BoardsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @board = @project.board
  end
end
