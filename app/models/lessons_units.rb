class LessonsUnits < ActiveRecord::Base
  attr_accessible :lesson_id, :unit_id

  belongs_to :unit
  belongs_to :lesson

  validates :unit_id, :presence => true
  validates :lesson_id, :presence => true
end