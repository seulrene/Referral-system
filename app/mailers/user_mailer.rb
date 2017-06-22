class UserMailer < ApplicationMailer
  default from: 'kalyanramswamy1@gamil.com'

  def referral_email(email, current_user)
    @email = email
    @user = current_user
    @url  = 'http://www.gmail.com'
    mail(to: @email, subject: 'Invitation from '+ @user.name)
  end
end
