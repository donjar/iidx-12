class ChartsController < ApplicationController
  def index
    @charts = Chart.process_from_params(params)
  end

  def refresh
    Chart.populate_data
    redirect_to root_path
  end

  def edit
    @chart = Chart.find(params[:id])
  end

  def update
    Chart.find(params[:id]).update(chart_params)
    redirect_to root_path(request.GET)
  end

  private

  def chart_params
    params.require(:chart).permit(:description, :target_clear, :target_priority)
  end
end
