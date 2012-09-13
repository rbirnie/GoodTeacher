class CreateVocabs < ActiveRecord::Migration
  def change
    create_table :vocabs do |t|
      t.string :name
      t.text :definition
      t.string :word
      t.text :location
      t.string :user_id
      t.string :vocab_list_id
      t.string :slug

      t.timestamps
    end
  end
end
