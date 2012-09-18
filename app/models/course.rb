class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :unit_links, :foreign_key => "course_id",
                        :dependent => :destroy
  has_many :units, :through => :unit_links 
  has_many :comments, :as => :commentable
  has_many :favorites, :as => :favorable

  attr_accessible :description, :name

  validates :name, :presence => true, 
                   :length => { :minimum => 2 },
                   :length => { :maximum => 150 },
                   :on => :update

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
