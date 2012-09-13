class Assessment < ActiveRecord::Base
  attr_accessible :prompt, :description, :name, :which

  has_many :assessments_units, :foreign_key => "assessment_id",
                               :dependent => :destroy
  has_many :units, :through => :assessments_units
  has_many :comments, :as => :commentable
end
