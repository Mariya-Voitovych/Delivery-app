class PackagePolicy < ApplicationPolicy
  def create?
    is_manager?(user)
  end
end
