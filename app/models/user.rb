class User < ActiveRecord::Base
  validates :first_name, :last_name, :birthday, :email, :password, presence: true
  has_many :tweets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
