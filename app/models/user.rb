class User < ActiveRecord::Base
  has_many :goals
  has_many :rating_answers, through: :goals
  has_many :comment_answers, through: :goals
end
