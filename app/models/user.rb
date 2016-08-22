class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :goals

  def to_s
    self.name
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
