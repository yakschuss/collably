class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

  #protected

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

end
