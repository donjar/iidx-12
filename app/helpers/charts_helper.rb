module ChartsHelper
  def bold(text)
    "<b>#{text}</b>".html_safe
  end

  def params_link(text, cls, **prms)
    link_to text, params.merge(prms).permit(:sort, :max_v, :max_clear,
                                            :min_pr, :sort_by),
            class: "btn #{cls}"
  end
end
