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

require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
