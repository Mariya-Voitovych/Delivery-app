class Package
  class Create
    def self.call(package_params)
      package = Package.create(package_params)
      package.tracking_number = "YA#{SecureRandom.alphanumeric(8)}AA"
      package.save
      package
    end
  end
end
