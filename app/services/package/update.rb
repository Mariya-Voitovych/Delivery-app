class Package
  class Update
    attr_accessor :id, :courier_id

    def initialize(id, courier_id)
      @id = id
      @courier_id = courier_id
    end

    def call
      update_package
    end

    private

    def update_package
      package = Package.find(@id)
      package.delivery_confirmation_token = Knock::AuthToken.new(payload: { sub: courier_id }).token
      package.delivery_confirmation_token_expiration = Time.now + 10*60
      package
    end
  end
end
