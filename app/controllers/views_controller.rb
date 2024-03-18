class ViewsController < ApplicationController
  before_action :set_link, only: [:show]

  def show
    @link = Link.find_by_code(params[:id])

    return redirect_to root_path, alert: "Link doesn't exist anymore" if @link.nil?

    @link.views.create(
      ip: request.ip,
      user_agent: request.user_agent
    )
    redirect_to @link.url, allow_other_host: true
  end

  private
    def link_params
      params.require(:link).permit(:url)
    end

    def set_link
    end

end
