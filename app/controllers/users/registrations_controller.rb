class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params,only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if sign_up_params[:ref_code].empty? || User.pluck(:user_ref).include?(sign_up_params[:ref_code])
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          resource.update(user_ref: SecureRandom.hex(6).upcase)
          if !sign_up_params[:ref_code].empty?
            resource.update(amount: 50)
            resource.update(referred: true)
            update_amount(sign_up_params[:ref_code])
            refered_user = User.where(user_ref: sign_up_params[:ref_code]).first
            NotificationsChannel.broadcast_to(
              "notifications_channel:#{refered_user.id}",
              notification: 'Account credited with Rs. 50 as '+resource.name+' used your Referrer code'
            )
          end
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      flash[:danger] = "invalid referral code"
      redirect_to new_user_registration_path
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
