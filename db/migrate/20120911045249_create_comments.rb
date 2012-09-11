class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commenter
      t.string :subject
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
