class ChangeCaseStatusType < ActiveRecord::Migration[5.1]
  def up
    remove_column :cases, :status
    add_column :cases, :status, :string
    Case.update_all(status: Case::Statuses::DESIGNATION)
  end

  def down
    remove_column :cases, :status
    add_column :cases, :status, :integer, default: 0
  end  
end
