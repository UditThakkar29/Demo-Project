class TicketsController < ApplicationController

  def show
    @ticket = Ticket.find(params[:id])
    @sprint = @ticket.sprints.last
    @project = Project.find(params[:project_id])
  end

  def new
    @ticket = Ticket.new
    @project = Project.find(params[:project_id])
    @sprint = Sprint.find(params[:sprint_id])
  end

  def create
    @ticket = Ticket.create(ticket_params)
    @sprint = Sprint.find(params[:sprint_id])
    if @ticket.save
      @ticket.sprint_tickets.create(sprint: @sprint)
      redirect_to project_board_sprint_path(id:@sprint)
    else
      render :new
    end
  end

  def doing
    @ticket = Ticket.find(params[:id])
    @sprint = Sprint.find(params[:sprint_id])
    @ticket.doing!
    redirect_to project_board_sprint_path(id:@sprint)
  end

  def testing
    @ticket = Ticket.find(params[:id])
    @sprint = Sprint.find(params[:sprint_id])
    @ticket.testing!
    redirect_to project_board_sprint_path(id:@sprint)
  end

  def done
    @ticket = Ticket.find(params[:id])
    @sprint = Sprint.find(params[:sprint_id])
    @ticket.done!
    redirect_to project_board_sprint_path(id:@sprint)
  end


  private
  def ticket_params
    params.require(:ticket).permit(:name,:summary,:priority,:status,:reporter_id)
  end
end
