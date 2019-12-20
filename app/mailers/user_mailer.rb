class UserMailer < ApplicationMailer


  def confirm_email(user)
    @user = user
    mail(to: @user.email, subject: 'Please confirm your account')
  end
  
end
