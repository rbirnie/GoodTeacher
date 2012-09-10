class Unit < ActiveRecord::Base
  belongs_to :course

  attr_accessible :description, :name

  validates :name, :presence => true, 
                   :length => { :minimum => 2,
                   :too_short => "Must be between 2 and 150 characters!",
                   :length => { :maximum => 150 },
                   :on => :update


end