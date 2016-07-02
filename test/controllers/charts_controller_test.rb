require 'test_helper'

class ChartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chart = charts(:one)
  end

  test "should get index" do
    get charts_url
    assert_response :success
  end

  test "should get new" do
    get new_chart_url
    assert_response :success
  end

  test "should create chart" do
    assert_difference('Chart.count') do
      post charts_url, params: { chart: { clear: @chart.clear, description: @chart.description, diff: @chart.diff, gimmicks: @chart.gimmicks, hc_level: @chart.hc_level, miss: @chart.miss, nc_level: @chart.nc_level, notes: @chart.notes, score: @chart.score, songid: @chart.songid, target_clear: @chart.target_clear, target_priority: @chart.target_priority, title: @chart.title, version: @chart.version } }
    end

    assert_redirected_to chart_url(Chart.last)
  end

  test "should show chart" do
    get chart_url(@chart)
    assert_response :success
  end

  test "should get edit" do
    get edit_chart_url(@chart)
    assert_response :success
  end

  test "should update chart" do
    patch chart_url(@chart), params: { chart: { clear: @chart.clear, description: @chart.description, diff: @chart.diff, gimmicks: @chart.gimmicks, hc_level: @chart.hc_level, miss: @chart.miss, nc_level: @chart.nc_level, notes: @chart.notes, score: @chart.score, songid: @chart.songid, target_clear: @chart.target_clear, target_priority: @chart.target_priority, title: @chart.title, version: @chart.version } }
    assert_redirected_to chart_url(@chart)
  end

  test "should destroy chart" do
    assert_difference('Chart.count', -1) do
      delete chart_url(@chart)
    end

    assert_redirected_to charts_url
  end
end
