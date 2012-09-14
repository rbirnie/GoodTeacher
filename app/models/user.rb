class User < ActiveRecord::Base
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :description, :name, :location, :school, :username
  # attr_accessible :title, :body

  has_many :courses, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :units,   :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :lessons, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :assessments, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :vocabulary_lists, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :comments, :as => :commentable
  has_many :authored_comments, class_name: "Comment"

  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
