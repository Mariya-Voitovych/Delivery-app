class PackageAssignmentPolicy < ApplicationPolicy
  def create?
    is_manager?(user) and record.package.aasm.current_state == :processing
  end
end
