class UsersController < ApplicationController
  protect_from_forgery
  #before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user,     only: :destroy
  #before_action :select_plan, only: :new

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new()
    @invite = Invite.find_by(params[:email])
    @token = Invite.find_by(token: params["invite_token"])

    @plan = params[:plan] == '3'

    if params[:plan] == '3'
      @company_name = User.find_by_name(request.subdomain)
      #@user = User.find_by(params[:subdomain])
      @invite = Invite.find_by(params[:email])
    end
    # if params[:plan] == '3'
    #   @user = User.find_by(params[:subdomain])
    #   Apartment::Tenant.switch!(@user.subdomain)
    # end

    @token = params[:invite_token] #<-- pulls the value from the url query string

  end

  def create
     @user = User.new(user_params)     # Not the final implementation!
    #@invite = Invite.email

    # if params[:plan] == '1' || params[:plan] == '2'
    #   @user.create_schema
    # end
    # @newUser = @user.build_user(user_params)
    # @newUser.save
    # @token = params[:invite_token]

    if params[:plan]
      @user.plan_id = params[:plan]
      if @user.plan_id == 2
        @user.save_with_subscription
      else
        @user.save
      end
    end

    if @token != nil
      org =  Invite.find_by_token(@token).user_group #find the user group attached to the invite
      @newUser.user_groups.push(org) #add this user to the new user group as a member
    elsif @user.plan_id == 3
      @user.save(validate: false)
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    elsif @user.valid?
      @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(session[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
  helper_method :current_user
  #hide_action :current_user
  private

    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2' || params[:plan] == '3')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :subdomain, :stripe_card_token)
    end

    # Before filters

    # Confirms a logged-in user.
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end



    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
