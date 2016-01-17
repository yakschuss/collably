class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

    has_many :event_user_roles
    has_many :events, through: :event_user_roles

end
