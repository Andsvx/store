class ApplicationController < ActionController::Base
  private

  def render_403
    render file: 'public/403.html', status: 403
  end

  def render_404
    render file: 'public/404.html', status: 404
  end

  def render_422
    render file: 'public/422.html', status: 422
  end

  def check_permission
    return true if current_user&.access_level == 1

    render_403
  end

  def check_authorization
    return true if user_signed_in?

    redirect_to new_user_session_path
  end
end
