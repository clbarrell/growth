class Question < ActiveRecord::Base
  has_many :rating_answers
  has_many :comment_answers
end
