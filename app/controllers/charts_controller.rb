class ChartsController < ApplicationController
  require 'open-uri'

  def index
    @charts = Chart.process_from_params(params)
  end

  def refresh
    Chart.populate_data
    redirect_to '/'
  end
end
