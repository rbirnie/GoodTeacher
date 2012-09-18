class Vocabulary < ActiveRecord::Base
  attr_accessible :definition, :name, :word, :location

  belongs_to :vocabulary_list

  has_many :comments, :as => :commentable
  has_many :favorites, :as => :favorable
end
