module ChartsHelper
  def bold(text)
    content_tag :b, text
  end

  def params_link(text, cls, **prms)
    link_to text, params.merge(prms).permit(:sort, :max_v, :max_clear,
                                            :min_pr, :sort_by),
            class: "btn #{cls}"

  end

  def clear_hash
    { '' => 0, 'EC' => 3, 'NC' => 4, 'HC' => 5, 'EXHC' => 6 }
  end
end
