class PackageAssignmentPolicy < ApplicationPolicy

  def index?
    is_courier?(user)
  end

  def create?
    is_manager?(user) and record.package.status_processing?
  end
end
