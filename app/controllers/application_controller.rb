class ApplicationController < ActionController::Base
  include Pundit
  include Knock::Authenticable
  protect_from_forgery with: :exception

  def access_denied(exception)
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

  private

  def require_valid_courier
    if Courier.find { |courier| courier.email == current_user.email }.validation != true
    redirect_to main_app.root_url
    end
  end
end
