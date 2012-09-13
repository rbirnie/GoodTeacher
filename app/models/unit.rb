class Unit < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :unit_links, :foreign_key => "unit_id",
                        :dependent => :destroy
  has_many :courses, :through => :unit_links
  has_many :lessons_unitss, :foreign_key => "unit_id",
                        :dependent => :destroy
  has_many :lessons, :through => :lessons_unitss
  has_many :assessments_units, :foreign_key => "unit_id",
                        :dependent => :destroy
  has_many :assessments, :through => :assessments_units
  has_many :vocabulary_lists_units, :foreign_key => "unit_id",
                        :dependent => :destroy
  has_many :vocabulary_lists, :through => :vocabulary_lists_units

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