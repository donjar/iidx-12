class ChartsController < ApplicationController
  require 'open-uri'

  def index
    @charts = Chart.all
  end

  def refresh
    username = params['chart']['username']
    mode = params['chart']['mode']
    level = params['chart']['level']
    link = "http://json.iidx.me/#{username}/#{mode}/level/#{level}/"
    Chart.populate_data(JSON.load(open(link)))
    redirect_to '/'
  end
end
