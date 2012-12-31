class Question < ActiveRecord::Base
  attr_accessible :modality, :question

  belongs_to :assessment
  has_many :answers, :foreign_key => "question_id",
                     :dependent => :destroy

end