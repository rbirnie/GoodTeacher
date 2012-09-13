class VocabularyListsUnit < ActiveRecord::Base
  attr_accessible :unit_id, :vocabulary_list_id

  belongs_to :unit
  belongs_to :vocabulary_list

  validates :unit_id, :presence => true
  validates :vocabulary_list_id, :presence => true
end
