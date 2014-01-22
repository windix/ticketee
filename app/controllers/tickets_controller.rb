class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)

    if @ticket.save
      redirect_to [@project, @ticket], notice: "Ticket has been created."
    else
      flash[:alert] = "Ticket has not been created."
      render 'new'
    end
  end

  def show

  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: "The project you were looking for could not be found."
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to project_tickets_path, alert: "The ticket you were looking for could not be found."
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end

end
