class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@ticket.project, @ticket], notice: "Comment has been created."
    else
      @states = State.all
      flash[:alert] = "Comment has not been created."
      render "tickets/show"
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The ticket you were looking for could not be found."
  end

  def comment_params
    params.require(:comment).permit(:content, :state_id)
  end

end
