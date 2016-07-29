module ChartsHelper
  def bold(text)
    content_tag :b, text
  end

  def params_link(text, cls, **prms)
    link_to text, params.merge(prms).permit(:sort, :max_v, :max_clear,
                                            :min_pr, :sort_by),
            class: "btn #{cls}"

  end

  def priority_hash
    { '' => nil, 'Low' => 1, 'Mid' => 2, 'High' => 3 }
  end
end
