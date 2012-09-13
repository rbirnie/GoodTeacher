class VocabList < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :description, :name, :vocabs_attributes

  has_many :vocabs, :foreign_key => "vocab_list_id",
                     :dependent => :destroy
  has_many :vocab_lists_units, :foreign_key => "vocab_list_id",
                               :dependent => :destroy
  has_many :units, :through => :vocab_lists_units
  has_many :comments, :as => :commentable

  accepts_nested_attributes_for :vocabs, :reject_if => lambda { |a| a[:word].blank? }, allow_destroy: true

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
