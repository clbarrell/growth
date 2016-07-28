class User < ActiveRecord::Base
  has_many :goals

  def to_s
    self.name
  end


end
