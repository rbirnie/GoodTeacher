class UnitLink < ActiveRecord::Base
  attr_accessible :course_id, :unit_id

  belongs_to :unit
  belongs_to :course

  validates :unit_id, :presence => true
  validates :course_id, :presence => true

end
