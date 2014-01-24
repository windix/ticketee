class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_signin!, except: [:index, :show]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      redirect_to [@project, @ticket], notice: "Ticket has been created."
    else
      flash[:alert] = "Ticket has not been created."
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: "Ticket has been updated."
    else
      flash[:alert] = "Ticket has not been updated."
      render "edit"
    end
  end

  def destroy
    @ticket.destroy
    redirect_to @project, notice: "Ticket has been destroyed."
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
