module InterviewHelper
  def bar_color(mark)
    case mark
    when 'green'
      'success'
    when 'yellow'
      'warning'
    when 'red'
      'danger'
    end
  end
end
