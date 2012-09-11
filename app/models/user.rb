class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :description, :name, :location, :school
  # attr_accessible :title, :body

  has_many :courses, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :units,   :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :comments, :as => :commentable
  has_many :authored_comments, class_name: "Comment"
  
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }
end
