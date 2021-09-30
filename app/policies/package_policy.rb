class PackagePolicy < ApplicationPolicy
  def create?
    user.respond_to? :email
  end
end