class PackageAssignmentPolicy < ApplicationPolicy
  def create?
    is_manager?(user) and record.package.status_processing?
  end
end
