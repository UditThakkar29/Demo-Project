class TicketsController < ApplicationController

  before_action :get_by_slug, only: [:show, :new, :create,:edit]
  before_action :get_by_slug_aasm, only: [:doing, :testing, :done]

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.create(ticket_params)
    # @sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
    if @ticket.save
      @ticket.sprint_tickets.create(sprint: @sprint)
      redirect_to project_board_sprint_path(slug:@sprint)
    else
      render :new
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to project_board_sprint_ticket_path(@ticket,project_slug: params[:project_slug],sprint_slug:params[:sprint_slug],board_slug:params[:board_slug])
    else
      render :edit
    end
  end

  def doing
    @ticket.doing!
    redirect_to project_board_sprint_path(slug:@sprint)
  end

  def testing
    @ticket.testing!
    redirect_to project_board_sprint_path(slug:@sprint)
  end

  def done
    @ticket.done!
    redirect_to project_board_sprint_path(slug:@sprint)
  end


  private

  def get_by_slug
    @project = Project.friendly.find_by_slug(params[:project_slug])
    # @board = @project.board
    @sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
  end

  def get_by_slug_aasm
    @ticket = Ticket.find(params[:id])
    @sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
  end

  def ticket_params
    params.require(:ticket).permit(:name,:summary,:priority,:status,:reporter_id,:assigned_to,:assigned_user_id)
  end
end
