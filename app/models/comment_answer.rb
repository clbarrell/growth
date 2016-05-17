class CommentAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :goal
end
