class Lesson < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :lessons_unitss, :foreign_key => "lesson_id",
                        :dependent => :destroy
  has_many :units, :through => :lessons_unitss

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }
  
  attr_accessible :body, :name, :description

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end

end
