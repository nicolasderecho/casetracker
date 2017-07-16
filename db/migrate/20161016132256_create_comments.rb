class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text     :description
      t.datetime :date
      t.integer  :commentable_id
      t.string   :commentable_type
      t.timestamps
    end
    add_reference :comments, :user, index: true, foreign_key: true
    add_index :comments, [:commentable_type, :commentable_id]
    add_index :comments, :date
  end
end
