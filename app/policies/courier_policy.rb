class CourierPolicy < ApplicationPolicy
  def create?
    is_manager?(user)
  end

  def update?
    is_manager?(user) || self_update(user)
  end

  def destroy?
    is_manager?(user)
  end
end
