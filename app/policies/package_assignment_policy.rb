class PackageAssignmentPolicy < ApplicationPolicy
  def index?
    is_courier?(user)
  end

  def create?
    is_manager?(user) and record.package.aasm.current_state == :processing
  end
end
