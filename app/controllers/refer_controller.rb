class ReferController < ApplicationController
  before_action :authenticate_user!
  def index
    @referral = Referral.new
    generate_ref
    if !current_user.referred
      referral = Referral.where(referral_email: current_user.email)
      if referral.any?
        referral = referral.first
        ref_valid = referral.user.user_ref
        if !ref_valid.blank?
          update_amount(current_user, referral.user)
          referral.update(status: true)
        end
      end
    end
  end

  def create
    if check_referral(current_user) && (current_user.email != referral_params[:referral_email])
      @referral = Referral.new(referral_email: referral_params[:referral_email], user_id: current_user.id, status: false)
      if @referral.save
        UserMailer.referral_email(referral_params[:referral_email], current_user).deliver
        update_referral(current_user)
        flash[:sucess] = "Referred Successfully"
        redirect_to root_path
      else
        flash[:danger] = "Email already referred"
        redirect_to root_path
      end
    else
      if (current_user.email == referral_params[:referral_email])
        flash[:danger] = "you can't refer your self"
      else
        flash[:danger] = "You have "+current_user.total_referral.to_s+ " referrals left"
      end
      redirect_to root_path
    end
  end

  def history
    generate_ref
    @refered = current_user.referred
    @referrals = current_user.referrals.where(status: true)
  end

  private
    def referral_params
      params.require(:referral).permit(:referral_email)
    end
end
