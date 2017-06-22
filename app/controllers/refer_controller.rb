class ReferController < ApplicationController
  before_action :authenticate_user!
  def index
    @referral = Referral.new
    if !current_user.referred
      referral = Referral.where(referral_email: current_user.email)
      if referral.any?
        update_amount(current_user, referral.first.user)
      end
    end
  end

  def create
    if check_referral(current_user) && (current_user.email != referral_params[:referral_email])
      @referral = Referral.new(referral_email: referral_params[:referral_email], user_id: current_user.id, status: false)
      if @referral.save
        UserMailer.referral_email(referral_params[:referral_email], current_user).deliver
        update_referral(current_user)
        flash[:sucess] = "referred successfully"
        redirect_to root_path
      else
        flash[:danger] = "Email already referred"
        redirect_to root_path
      end
    else
      if (current_user.email == referral_params[:referral_email])
        flash[:danger] = "you can't refer your self"
      else
        flash[:danger] = "You have "+current_user.total_referral+ " left"
      end
      redirect_to root_path
    end
  end

  private
    def referral_params
      params.require(:referral).permit(:referral_email)
    end
end
