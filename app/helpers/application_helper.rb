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

end
