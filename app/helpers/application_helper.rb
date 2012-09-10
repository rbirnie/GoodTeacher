module ApplicationHelper

  def flash_class(level)
    case level
    when :notice then 'info'
    when :error then 'error'
    when :alert then 'warning'
    end
  end

  # Return a title on a per-page basis.
  def title
    base_title = "GoodTeacher"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end

end
