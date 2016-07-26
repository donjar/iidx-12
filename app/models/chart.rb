# == Schema Information
#
# Table name: charts
#
#  id              :integer          not null, primary key
#  songid          :integer
#  diff            :string
#  notes           :integer
#  title           :string
#  version         :integer
#  clear           :integer
#  score           :integer
#  miss            :integer
#  nc_level        :integer
#  hc_level        :integer
#  target_clear    :integer
#  target_priority :integer
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  just_updated    :boolean
#  nc_gimmicks     :boolean
#  hc_gimmicks     :boolean
#

class Chart < ApplicationRecord
  enum clear: { 'white' => 0, 'gray' => 1, 'pink' => 2, 'green' => 3,
                'blue' => 4, 'red' => 5, 'yellow' => 6, 'teal' => 7 }
  enum diff: { '[a]' => 'spa', '[h]' => 'sph', '[n]' => 'spn' }

  require 'open-uri'
  @chart_hash = JSON.load open('http://json.iidx.me/donjar/sp/level/12/')
  @level_hash = JSON.load open('http://iidx.insane.pe.kr/json/musiclist/sp/level/12/')

  NC = '노멀'.freeze
  NC_GIMMICKS = '노멀 개인차'.freeze
  HC = '처리력'.freeze
  HC_GIMMICKS = '개인차'.freeze

  def to_s
    title + " " + diff
  end

  def self.populate_data
    @chart_hash['musicdata'].each do |chart|
      c = Chart.find_by(songid: chart['data']['id'],
                        diff: chart['data']['diff']) || Chart.new
      level_data = @level_hash['songs'].find do |s|
        s['songtitle'] == chart['data']['title']
      end
      update_from_data chart, level_data, c
    end

    remove_not_updated
  end

  def self.get_level(categories)
    if (desc = categories.find { |c| c.starts_with? NC })
      nc = desc.gsub("#{NC} ", '')
      nc_gimmicks = false
    end
    if (desc = categories.find { |c| c.starts_with? NC_GIMMICKS })
      nc = desc.gsub("#{NC_GIMMICKS} ", '')
      nc_gimmicks = true
    end

    if (desc = categories.find { |c| c.starts_with? HC })
      hc = desc.gsub("#{HC} ", '')
      hc_gimmicks = false
    elsif (desc = categories.find { |c| c.starts_with? HC_GIMMICKS })
      hc = desc.gsub("#{HC_GIMMICKS} ", '')
      hc_gimmicks = true
    end

    letter_to_number = { 'S+' => 10, 'S' => 9, 'A+' => 8, 'A' => 7, 'B+' => 6,
      'B' => 5, 'C' => 4, 'D' => 3, 'E' => 2, 'F' => 1 }
    { nc: letter_to_number[nc], nc_gimmicks: nc_gimmicks,
      hc: letter_to_number[hc], hc_gimmicks: hc_gimmicks }
  end

  def self.update_from_data(song_data, level_data, chart_object)
    song = song_data['data']
    level = if level_data.nil?
              { nc: nil, hc: nil, nc_gimmicks: nil, hc_gimmicks: nil }
            else
              get_level level_data['categories']
            end
    chart_object.update(songid: song['id'], diff: song['diff'],
                        notes: song['notes'], title: song['title'],
                        version: song['version'], clear: song_data['clear'],
                        score: song_data['score'], miss: song_data['miss'],
                        nc_level: level[:nc], hc_level: level[:hc],
                        nc_gimmicks: level[:nc_gimmicks],
                        hc_gimmicks: level[:hc_gimmicks],
                        just_updated: true)
  end

  def self.remove_not_updated
    Chart.all.find_each do |chart|
      if chart.just_updated?
        chart.update(just_updated: false)
      else
        chart.destroy
      end
    end
  end

  def calc_rank
    return if score.nil?
    res = score
    inc = 2 * notes / 9
    rank = 0
    loop do
      res -= inc
      return format_rank(rank, (inc + res), res) if res < 0
      rank += 1
    end
  end

  def format_rank(rank, plus, minus)
    rank_array = %w(O F E D C B A AA AAA)
    curr_rank = rank_array[rank]
    next_rank = rank_array[rank + 1]
    "#{curr_rank}+#{plus} (#{next_rank}#{minus})"
  end

  def self.process_from_params(params)
    params[:sort] ||= 'title'
    res = all
    res = res.where('version <= ?', params[:max_v]) if params[:max_v]
    res = res.where('clear <= ?', params[:max_clear]) if params[:max_clear]
    res = res.where('target_priority <= ?', params[:min_pr]) if params[:min_pr]
    res = res.order(params[:sort].to_s) if params[:sort]
    res = res.reverse if params[:sort_by] == 'descending'
    res
  end
end
