class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug, only: [:index,:show]

  def index
    @sprints = @board.sprints
  end

  def show
  end

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:project_slug])
    @board = @project.board
  end
end
