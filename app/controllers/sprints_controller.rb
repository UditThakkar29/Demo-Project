class SprintsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @board = @project.board
  end

  def new
    
  end
end
