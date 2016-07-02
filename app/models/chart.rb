class Chart < ApplicationRecord
  enum clear: { 'white' => 0, 'gray': 1, 'pink': 2, 'green': 3, 'blue': 4,
                'red': 5, 'yellow': 6, 'teal': 7 }
  enum diff: { '[a]' => 'spa', '[h]' => 'sph', '[n]' => 'spn' }

  def self.populate_data(iidx_me_hash)
    iidx_me_hash['musicdata'].each do |chart|
      c = Chart.find_by(songid: chart['data']['id'],
                        diff: chart['data']['diff']) || Chart.new
      update_from_data(chart, c)
    end

    remove_not_updated
  end

  def self.update_from_data(data, chart_object)
    song = data['data']
    chart_object.update(songid: song['id'], diff: song['diff'],
                        notes: song['notes'], title: song['title'],
                        version: song['version'], clear: data['clear'],
                        score: data['score'], miss: data['miss'],
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
end
