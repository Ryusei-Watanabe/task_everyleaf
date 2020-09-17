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
  def logged_user_session_new
    unless current_user.nil?
      redirect_to tasks_path, notice: "ログイン中です"
    end
  end
  def user_admin?
    unless current_user.admin?
      redirect_to root_path, notice: t('view.NoAdmin')
    end
  end
end
