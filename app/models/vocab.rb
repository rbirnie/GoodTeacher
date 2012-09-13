class Vocab < ActiveRecord::Base
  attr_accessible :definition, :name, :word, :location

  belongs_to :vocab_list

  has_many :comments, :as => :commentable
end
