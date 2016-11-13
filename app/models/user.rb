class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :goals
  has_many :social_goal_records

  def to_s
    if self.name
      "#{self.name} <#{self.email}>"
    else
      self.email
    end
  end

  # social_goal_records stuff
  def social_goals
    Goal.joins(:social_goal_records).where(social_goal_records: { user: current_user })
  end


  # TURN THIS INTO A COLUMN variable
  # takes too much data loading
  def checkin_ready_goals
    count = 0
    goals.each do |x|
      count += 1 if x.is_it_checkin_time?
    end
    count
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
       user = User.create(name: data["name"],
          email: data["email"],
          password: Devise.friendly_token[0,20]
       )
    end
    user
  end

end
