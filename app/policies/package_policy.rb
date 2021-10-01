class PackagePolicy < ApplicationPolicy
  def create?
    user.delivery_manager?
  end
end
