class Question < ActiveRecord::Base
  has_many :rating_answers
  has_many :comment_answers
  has_and_belongs_to_many :goals, -> { readonly }

  # -- FIELDS --
  # question - text of question
  # qntype - checkin / review
  # scale - text / rating / agreement

end
