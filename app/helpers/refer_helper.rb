module ReferHelper
  def update_amount(ref_code)
    @user_details = User.where(user_ref: ref_code).first
    @user_details.update(amount: @user_details.amount + 50)
  end
end
