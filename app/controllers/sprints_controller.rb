# frozen_string_literal: true

# Controller for sprint
class SprintsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_slug, only: %i[show new create end_sprint backlog_tickets sprint_report]
  before_action :can_be_ended, only: %i[end_sprint]
  before_action :find_sprints, only: %i[select_sprint]

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
    if Sprint.where(current_sprint: true).count == 0 and Sprint.name!="Backlog"
      @sprint.current_sprint = true
    end
    @sprint.total_story_points = 0
    @sprint.completed_story_points = 0

    if @sprint.save
      redirect_to project_board_sprint_path(slug: @sprint)
    else
      render :new
    end
  end

  def end_sprint
    # before action working for the method
  end

  def select_sprint
    @tickets = []
    @previous_sprint.tickets.each do |ticket|
      @tickets << ticket if ticket.status != 'done'
      if ticket.status == 'done'
        @previous_sprint.completed_story_points += ticket.story_point
        @previous_sprint.save
        debugger
      end
    end

    @tickets.each do |ticket|
      @current_sprint.sprint_tickets.create(ticket: ticket)
      ticket.reset!
    end
    update_state
    redirect_to sprint_report_project_board_sprint_path(slug: @previous_sprint)
  end

  def backlog_tickets
    @sprint = Sprint.friendly.find_by_slug(params[:slug])
  end

  def sprint_report
  end

  private

  def find_by_slug
    @project = current_user.projects.friendly.find_by_slug(params[:project_slug])
    @board = @project.board
    @sprint = Sprint.friendly.find_by_slug(params[:slug])
  end

  def find_sprints
    @previous_sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
    @current_sprint = Sprint.friendly.find_by_slug(params[:slug])
  end

  def update_state
    @previous_sprint.current_sprint = false
    @current_sprint.current_sprint = true
    @previous_sprint.save
    @current_sprint.save
  end

  def can_be_ended
    flag = check_if_sprint_complete
    is_present = false
    @tickets = []
    @board.sprints.each do |sprint|
      is_present = true if sprint.current_sprint.nil? && sprint.backlog_sprint.nil?
    end
    if flag && is_present
    else
      if flag == false
        redirect_to project_board_sprint_path(slug: @sprint), alert: "You cannot end sprint before it's end time"
      else
        redirect_to new_project_board_sprint_path(board_slug: @board), alert: 'No sprint to transfer tickets to, Create a ticket first then try again!'
      end
    end
  end

  def check_if_sprint_complete
    time_passed = (DateTime.now.to_date - @sprint.start_time.to_date).to_i
    if @sprint.duration <= time_passed
      return true
    else
      return false
    end
  end

  def sprint_params
    params.require(:sprint).permit(:name, :start_time, :goal, :duration,:image)
  end
end
