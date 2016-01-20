class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

    has_many :roles, class_name: "EventUserRole"
    has_many :events, through: :roles

end
