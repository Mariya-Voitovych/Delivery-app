class CourierPolicy < ApplicationPolicy
  def create?
    user.delivery_manager?
  end

  def update?
    user.delivery_manager?
  end

  def destroy?
    user.delivery_manager?
  end
end
