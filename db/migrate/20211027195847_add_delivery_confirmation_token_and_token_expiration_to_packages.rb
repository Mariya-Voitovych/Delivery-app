class AddDeliveryConfirmationTokenAndTokenExpirationToPackages < ActiveRecord::Migration[6.1]
  def change
    add_column :packages, :delivery_confirmation_token, :string
    add_column :packages, :delivery_confirmation_token_expiration, :timestamp
  end
end
