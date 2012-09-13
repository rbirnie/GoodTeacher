class AssessmentsUnit < ActiveRecord::Base
  attr_accessible :assessment_id, :unit_id

  belongs_to :unit
  belongs_to :assessment

  validates :unit_id, :presence => true
  validates :assessment_id, :presence => true
end
