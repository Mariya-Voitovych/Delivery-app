class PackageAssignment
  class SetDeliveryStatusAssigned
    def initialize(package_assignment)
      @package_assignment = package_assignment
    end

    def call
      set_delivery_status_assigned
    end

    private

    def set_delivery_status_assigned
      @package_assignment.package.delivery_status = 'assigned'
    end
  end
end
