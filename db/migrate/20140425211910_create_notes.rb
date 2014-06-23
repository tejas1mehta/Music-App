class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false
      t.integer :track_id, null: false
      t.text :body_text, null:false

      t.timestamps
    end
    add_index :notes, :track_id
    add_index :notes, :user_id
  end
end
