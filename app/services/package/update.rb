class Package
  class Update
    attr_accessor :package_params, :package

    def initialize(package_params, package)
      @package_params = package_params
      @package = package
    end

    def call
      update_package
    end

    private

    def update_package
      @package_params[:delivery_status] = 'delivered'  if @package.delivery_confirmation_token_expiration <= Time.now         
      @package_params
    end
  end
end
