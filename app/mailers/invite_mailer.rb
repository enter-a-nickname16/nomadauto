class InviteMailer < ActionMailer::Base
 default from: "noreply@nomadauto.com"

 def new_user_invite(invite)
    @invite = invite
    @invite_plan = Plan.find(3)
    mail to: invite.email, subject: "Account Invitation"
    #mail to: invite.email, subject: "Account Invitation"
 end

 def existing_user_invite(invite)
    @invite = invite
    mail to: invite.email, subject: "Account Invitation"
 end
end
