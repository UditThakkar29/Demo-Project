class TicketsController < ApplicationController

  before_action :get_by_slug, only: [:show, :new, :create]
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
    @sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
  end

  def get_by_slug_aasm
    @ticket = Ticket.find(params[:id])
    @sprint = Sprint.friendly.find_by_slug(params[:sprint_slug])
  end

  def ticket_params
    params.require(:ticket).permit(:name,:summary,:priority,:status,:reporter_id)
  end
end
