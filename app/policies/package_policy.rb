class PackagePolicy < ApplicationPolicy
  def create?
    is_manager?(user)
  end

  def show?
    is_courier?(user)
  end
end
