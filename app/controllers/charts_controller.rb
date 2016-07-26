class ChartsController < ApplicationController
  def index
    @charts = Chart.process_from_params(params)
  end

  def refresh
    Chart.populate_data
    redirect_to '/'
  end

  def update
    c = Chart.find(params[:id])
    c.update(chart_params)
  end

  private
  
  def chart_params
    params.permit(:id, :target_clear, :target_priority)
  end
end
