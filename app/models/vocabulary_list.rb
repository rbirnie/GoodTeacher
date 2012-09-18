class VocabularyList < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :description, :name, :vocabularies_attributes

  has_many :vocabularies, :foreign_key => "vocabulary_list_id",
                     :dependent => :destroy
  has_many :vocabulary_lists_units, :foreign_key => "vocabulary_list_id",
                               :dependent => :destroy
  has_many :units, :through => :vocabulary_lists_units
  has_many :comments, :as => :commentable
  has_many :favorites, :as => :favorable

  accepts_nested_attributes_for :vocabularies, :reject_if => lambda { |a| a[:word].blank? }, allow_destroy: true

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
