class Course < ActiveRecord::Base
  belongs_to :user

  has_many :unit_links, :foreign_key => "course_id",
                        :dependent => :destroy
  has_many :units, :through => :unit_links 


  attr_accessible :description, :name, :user_id

  validates :name, :presence => true, 
                   :length => { :minimum => 2 },
                   :length => { :maximum => 150 },
                   :on => :update

end
