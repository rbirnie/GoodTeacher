class Favorite < ActiveRecord::Base
  
  belongs_to :favorable, :polymorphic => true
  belongs_to :favorer, class_name: "User", foreign_key: :favorer

  attr_accessible :favorer
end