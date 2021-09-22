class OnlyActiveManagersAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    user.enabled
  end
end
