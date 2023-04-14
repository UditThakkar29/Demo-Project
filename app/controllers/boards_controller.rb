# frozen_string_literal: true

# Controller for handling all the action related to the board model
class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug

  def index
    @sprints = @board.sprints.current_sprint
    @backlog = @board.sprints.backlog_sprint
  end

  def show; end

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:project_slug])
    @board = @project.board
    raise ActiveRecord::RecordNotFound if @board.nil?
  end
end
