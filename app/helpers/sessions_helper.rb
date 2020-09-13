module SessionsHelper
  def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end
def logged_in?
  current_user.present?
end
def logged_user
  if logged_in? == true
    redirect_to tasks_path
  end
end
end
