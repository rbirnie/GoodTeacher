class Assessment < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :prompt, :description, :name, :which

  has_many :assessments_units, :foreign_key => "assessment_id",
                               :dependent => :destroy
  has_many :units, :through => :assessments_units
  has_many :comments, :as => :commentable
  has_many :favorites, :as => :favorable

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
