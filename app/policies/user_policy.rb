class UserPolicy < ApplicationPolicy

  def show
    record.id == user.id
  end

  def update?
    record.id == user.id
  end

  def change_password?
    record.id == user.id
  end

  def update_password?
    record.id == user.id
  end

end