class Package
  class Create
    def initialize(package_params)
      @package_params = package_params
    end

    def call
      create_paskage
    end

    private

    def create_paskage
      package = Package.create(@package_params)
      package.tracking_number = "YA#{SecureRandom.alphanumeric(8)}AA"
      package.save
      package
    end
  end
end
