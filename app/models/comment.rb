class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :commenter, class_name: "User", foreign_key: :commenter

  attr_accessible :body, :subject
end