class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
    @invite_plan = Plan.find(3)
  end

  def create
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
    @invite_plan = Plan.find(3)

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # Log the user in and redirect to the user's show page.
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to projects_url(subdomain: user.subdomain)
      else
        message  = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
    # else
    #   flash.now[:danger] = 'Invalid email/password combination'
    #   render 'new'
    # end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url(subdomain: 'www')
  end
end
