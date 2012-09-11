class Unit < ActiveRecord::Base
  belongs_to :user

  has_many :unit_links, :foreign_key => "unit_id",
                        :dependent => :destroy
  has_many :courses, :through => :unit_links
  has_many :comments, :as => :commentable

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }

  attr_accessible :description, :name

  validates :name, :presence => true, 
                   :length => { :minimum => 2 },
                   :length => { :maximum => 150 },
                   :on => :update

end
