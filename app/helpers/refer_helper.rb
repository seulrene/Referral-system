module ReferHelper
  def check_referral(user)
    if user.total_referral == 0
      return false
    elsif user.no_of_referrals != 0
      return true
    elsif user.total_referral > 0
      return true
    end
  end

  def update_referral(user)
    if check_referral(user)
      user.update(no_of_referrals: user.no_of_referrals+1)
      user.update(total_referral: user.total_referral-1)
      return true
    else
      return false
    end
  end

  def update_amount(present_user, refered_user)
    present_user.update(amount: present_user.amount + 50)
    refered_user.update(amount: refered_user.amount + 50)
    present_user.update(referred: true)
  end

  def generate_ref
    if current_user.user_ref.blank?
      User.update(user_ref: SecureRandom.hex(6).upcase)
    end
  end
end
