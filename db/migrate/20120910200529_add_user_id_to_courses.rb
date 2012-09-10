class AddUserIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :user_id, :integer
    add_column :units, :course_id, :integer
  end
end
