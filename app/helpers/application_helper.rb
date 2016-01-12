module ApplicationHelper
  def full_title(page_title = nil)
    [page_title, "AID-Interview"].compact.join(" | ")
  end

  def panel_title(count, title)
    content_tag(:h2, count) + content_tag(:h4, title)
  end
end
