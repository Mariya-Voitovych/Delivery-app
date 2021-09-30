class CourierPolicy < ApplicationPolicy
  def create?
    user.respond_to? :enabled
  end
  def update?
    user.respond_to? :enabled
  end
  def destroy?
    user.respond_to? :enabled
  end
end