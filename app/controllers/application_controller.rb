class ApplicationController < ActionController::Base
  include ReferHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_up_path_for(resource_or_scope)
  #   if !current_user.refered
  #     referral = Referral.where(referral_email: current_user.email)
  #     if referral.any?
  #       update_amount(current_user, referral.first.user)
  #     end
  #   end
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :age, :gender])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :gender, :about, :current_password, :password])
  end
end
