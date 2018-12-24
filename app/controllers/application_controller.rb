class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery prepend: true, with: :exception
  helper_method [:current_account, :logged_in?]

  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]


  #before_action :load_schema
  #before_action :authenticate_user!

  #Whitelist the following form fields, so we can process them, if coming from
  #a devise signup form.
  #before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper
  helper_method :current_user

  # make expire_on method available for all the controllers
  helper_method :all
  helper_method :remaining_days
  helper_method :trial_expired?

   # find the remaining trial days for this user
  def remaining_days
    ((current_account.created_at + 30.days).to_date - Date.today).round
  end

  def trial_expired?
    # find current_user who is login. If you are using devise simply current_user will works
    # now that you have remaining_days, check whether trial period is already completed
    if remaining_days <= 0
      redirect_to projects_path
    end
  end

  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

  private

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
    end
    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    # end

    # def load_schema
    #   Apartment::Tenant.switch!('public')

    #   return unless request.subdomain.present?

    #   user = User.find_by(subdomain: request.subdomain)
    #   if user
    #     Apartment::Tenant.switch!(user.subdomain)
    #   else
    #     redirect_to login_url(subdomain: false)
    #   end
    # end

    def current_account
      @current_account ||= User.find_by(subdomain: request.subdomain)
    end

    def set_mailer_host
      subdomain = current_account ? "#{current_account.subdomain}." : ""
      ActionMailer::Base.default_url_options[:host] = "#{subdomain}lvh.me:3000"
    end


    def after_sign_out_path_for(resource_or_scope)
      redirect_to logout_path(subdomain: 'www')
    end

    def after_invite_path_for(resource_or_scope)
      users_path
    end

    def user_not_authorized
      flash[:alert] = "You are not cool enough to do this - go back from whence you came."
      redirect_to(projects_path)
    end
end
