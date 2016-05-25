module ApplicationHelper

  def toast_link(link_msg, toast_msg, link, time = 'normal')
    # Probably don't need this anymore... until I've got asynch JS
    if time == "quick"
      link_to link_msg, link, class: "btn", onclick: "Materialize.toast(\'#{toast_msg}\', 2000)"
    elsif time == "normal"
      link_to link_msg, link, class: "btn", onclick: "Materialize.toast(\'#{toast_msg}\', 4000)"
    elsif
      link_to link_msg, link, class: "btn", onclick: "Materialize.toast(\'#{toast_msg}\', 6000)"
    end
  end

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

  

end
