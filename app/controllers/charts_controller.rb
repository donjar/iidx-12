class ChartsController < ApplicationController
  before_action :set_chart, only: [:show, :edit, :update, :destroy]

  # GET /charts
  def index
    @charts = Chart.all
  end

  # GET /charts/1
  def show
  end

  # GET /charts/new
  def new
    @chart = Chart.new
  end

  # GET /charts/1/edit
  def edit
  end

  # POST /charts
  def create
    @chart = Chart.new(chart_params)

    if @chart.save
      redirect_to @chart, notice: 'Chart was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /charts/1
  def update
    if @chart.update(chart_params)
      redirect_to @chart, notice: 'Chart was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /charts/1
  def destroy
    @chart.destroy
    redirect_to charts_url, notice: 'Chart was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chart_params
      params.require(:chart).permit(:songid, :diff, :notes, :title, :version, :clear, :score, :miss, :gimmicks, :nc_level, :hc_level, :target_clear, :target_priority, :description)
    end
end
