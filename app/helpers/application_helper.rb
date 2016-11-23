module ApplicationHelper

  def people_with_access(goal)
    User.joins(:social_goal_records).where(social_goal_records: { goal: goal })
  end

  def anyone_have_access?(goal)
    SocialGoalRecord.where(goal: goal).any?
  end

  def whose_goal(goal)
    if current_user == goal.user
      "you've"
    else
      goal.user.email_name.concat(" has")
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

  # to use active LI
  def link_to_in_li(body, url, html_options = {})
    active = "active" if current_page?(url)
    content_tag :li, class: active do
      link_to body, url, html_options
    end
  end

  def link_to_in_li_with_span(body, url, span, html_options = {})
    active = "active" if current_page?(url)
    text = "#{body} <span class='label label-info'>#{span}</span>".html_safe
    content_tag :li, class: active do
      link_to text, url, html_options
    end
  end

  def display_goal_name?
    if controller.controller_name == "goals" || controller.controller_name == "questions"
      # controller
      if ["show", "edit", "checkin", "checkin_answers", "social"].include?(controller.action_name)
        # ACTION
        true if current_user == @goal.user #only show if owner of goal
      elsif controller.controller_name == "questions" && ["new", "index"].include?(controller.action_name)
        true if current_user == @goal.user #only show if owner of goal
      else
        false
      end
    else
      false
    end
  end

  def display_goal_answers?
    if controller.controller_name == "goals" || controller.controller_name == "questions"
      # controller
      if ["show", "edit", "checkin", "checkin_answers"].include?(controller.action_name)
        # ACTION
        true
      elsif controller.controller_name == "questions" && ["new", "index"].include?(controller.action_name)
        true
      else
        false
      end
    else
      false
    end
  end

  def cog_icon
    content_tag :span, class: "glyphicon glyphicon-cog", 'aria-hidden' => "true" do
    end
  end

  def time_icon
    content_tag :span, class: "glyphicon glyphicon-time", 'aria-hidden' => "true" do
    end
  end

  def trash_icon
    content_tag :span, class: "glyphicon glyphicon-trash", 'aria-hidden' => "true" do
    end
  end

  def list_icon
    content_tag :span, class: "glyphicon glyphicon-th-list", 'aria-hidden' => "true" do
    end
  end

  def eye_icon
    content_tag :span, class: "glyphicon glyphicon-eye-open", 'aria-hidden' => "true" do
    end
  end

  def stats_icon
    content_tag :span, class: "glyphicon glyphicon-stats", 'aria-hidden' => "true" do
    end
  end

  def plus_icon
    content_tag :span, class: "glyphicon glyphicon-plus", 'aria-hidden' => "true" do
    end
  end

  def pencil_icon
    content_tag :span, class: "glyphicon glyphicon-edit", 'aria-hidden' => "true" do
    end
  end

  def home_icon
    content_tag :span, class: "glyphicon glyphicon-home", 'aria-hidden' => "true" do
    end
  end
  def question_icon
    content_tag :span, class: "glyphicon glyphicon-question-sign", 'aria-hidden' => "true" do
    end
  end

  def briefcase_icon
    content_tag :span, class: "glyphicon glyphicon-briefcase", 'aria-hidden' => "true" do
    end
  end
  def share_icon
    content_tag :span, class: "glyphicon glyphicon-share", 'aria-hidden' => "true" do
    end
  end


  def show_checkins?
    if current_user.checkin_ready_goals > 0
      if display_goal_name?
        if @goal.is_it_checkin_time? == false
          true
        end
      else
        true
      end
    else
      false
    end
  end
end
