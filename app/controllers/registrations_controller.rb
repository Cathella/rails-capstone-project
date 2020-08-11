class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

  def after_sign_up_path_for(_resource)
    '/profile'
  end

  def after_sign_in_path_for(_resource)
    '/profile'
  end

end
