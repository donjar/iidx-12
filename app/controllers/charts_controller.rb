class ChartsController < ApplicationController
  def index
    @charts = Chart.process_from_params(params)
  end

  def refresh
    Chart.populate_data
    redirect_to '/'
  end

  def edit
    @chart = Chart.find(params[:id])
  end

  def update
    Chart.find(params[:id]).update(chart_params)
    redirect_to '/'
  end

  private

  def chart_params
    params.permit(:id, :target_clear, :target_priority)
  end
end
