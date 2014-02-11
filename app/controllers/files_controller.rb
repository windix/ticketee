class FilesController < ApplicationController
  before_action :require_signin!

  def show
    asset = Asset.find(params[:id])

    if current_user.admin? || can?(:view, asset.ticket.project)
      send_file asset.asset.path,
                filename: asset.asset_identifier,
                content_type: asset.content_type
    else
      redirect_to root_path, alert: 'The asset you were looking for could not be found.'
    end
  end

  def new
    @ticket = Ticket.new
    asset = @ticket.assets.build

    render partial: "form", locals: { n: params[:n].to_i, asset: asset }
  end

end
