module QuestionsHelper

  def scale_options
    %w(Agreement Rating Text True/False)
  end

  def current_orders
      "Checkins: #{Question.checkin.uniq.pluck(:default_order)},
      Reviews: #{Question.review.uniq.pluck(:default_order)}"
  end
end
