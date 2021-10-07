class Package
  class Create
    def initialize(package_params)
      @package_params = package_params
    end

    def call
      create_package
    end

    private

    def create_package
      courier = Courier.find(@package_params[:courier_id])
      package = courier.packages.new(@package_params)
      package.tracking_number = "YA#{SecureRandom.alphanumeric(8)}AA"
      package.save
      package
    end
  end
end
