class CreateCases < ActiveRecord::Migration[5.0]
  def change
    create_table :cases do |t|
      t.string   :title
      t.string   :expedient
      t.string   :judge
      t.datetime :date
      t.integer  :status, default: 0
      t.timestamps
    end
    add_reference :cases, :user, index: true, foreign_key: true
    add_index :cases, :title
    add_index :cases, :expedient
    add_index :cases, :date
    add_index :cases, :judge
    add_index :cases, :status
  end
end
