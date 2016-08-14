module ApplicationHelper


  #Turns alerts into bootstrap ones
  def bootstrap_class_for flash_type
    case flash_type.to_s
      when "success"
        "alert-success" # Green
      when "error"
        "alert-danger" # Red
      when "alert"
        "alert-warning" # Yellow
      when "notice"
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end

  def current_user
    User.find(1)
  end

  # to use active LI
  def link_to_in_li(body, url, html_options = {})
    active = "active" if current_page?(url)
    content_tag :li, class: active do
      link_to body, url, html_options
    end
  end

  def link_to_in_li_with_span(body, url, span, html_options = {})
    active = "active" if current_page?(url)
    text = "#{body} <span class='badge'>#{span}</span>".html_safe
    content_tag :li, class: active do
      link_to text, url, html_options
    end
  end

  def display_goal_name?
    if controller.controller_name == "goals" || controller.controller_name == "questions"
      # controller
      if ["show", "edit", "checkin", "checkin_answers"].include?(controller.action_name)
        # ACTION
        true
      else
        false
      end
    else
      false
    end
  end
end
