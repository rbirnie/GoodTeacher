class Lesson < ActiveRecord::Base

  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :lessons_unitss, :foreign_key => "lesson_id",
                        :dependent => :destroy
  has_many :units, :through => :lessons_unitss

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }
  
  attr_accessible :body, :name, :description
end
