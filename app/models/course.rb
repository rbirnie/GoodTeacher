class Course < ActiveRecord::Base
  belongs_to :user

  has_many :units, :dependent => :destroy

  attr_accessible :description, :name, :user_id

  validates :name, :presence => true, 
                   :length => { :minimum => 2 },
                   :length => { :maximum => 150 },
                   :on => :update

end
