class VocabListsUnit < ActiveRecord::Base
  attr_accessible :unit_id, :vocab_list_id

  belongs_to :unit
  belongs_to :vocab_list

  validates :unit_id, :presence => true
  validates :vocab_list_id, :presence => true
end
