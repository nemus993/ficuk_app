class User < ActiveRecord::Base
  validates :first_name, :last_name, :birthday, :email, :password, presence: true

  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :pasive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :pasive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #Follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  #Unfollow a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  #Checks if current_user is following other
  def following?(other_user)
    following.include?(other_user)
  end
end
