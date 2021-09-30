class OnlyActiveManagersAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(_action, _subject = nil)
    user.enabled
  end
end
