module Users
  class InvitesController < UsersController
    before_action :trial_expired?

    def index
      @users = current_account.invitelist

      @invite = Invite.new

      # if UserGroup.first == nil
      #   Invite.create()
      # end
      @subdomain = request.subdomain
    end

    def new
    @project = Project.find(params[:project_id])

    @invite = @project.invites.build
    authorize @invite

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deal }
    end

      @invite = Invite.new

      @token = params[:invite_token] #<-- pulls the value from the url query string
      @user = User.new(params[:subdomain])
    end

    def create
    #1st you retrieve the project thanks to params[:project_id]
    @project = Project.find(params[:project_id])

    #2nd you create the task with arguments in params[:task]
    @invite = @project.invites.create(invite_params)

     # Not the final implementation!
     @invite = Invite.new(invite_params) # Make a new Invite
     @invite.sender_id = logged_in_user # set the sender to the current user

     #create the invite records
     #@project = current_account.projects.build(project_params)

       if @invite.save

       track_activity @invite

        if @invite.recipient != nil
          #send a notification email

           InviteMailer.existing_user_invite(@invite).deliver
           flash[:notice] = "Invitation sent"
           redirect_to(project_invites_url) and return
           #Add the user to the user group
           #@invite.recipient.user_groups.push(@invite.user_group)
        else
          @invite.new_user_invite #send the invite data to our mailer to deliver the email
          flash[:notice] = "Invitation sent"
          redirect_to(project_invites_url) and return
        end

       else
        flash.now[:notice] = "Something went wrong"

       end


    end

   def edit
    invite = Invite.find_by(id: params[:id])
    if invite

      @user = User.find_by(params[:subdomain])
      # redirect_to signup_url(subdomain: user.subdomain)
    else
      flash[:danger] = "Invalid Invitation link"
      redirect_to root_url
    end
  end


    private

    # def user_params
    #   params.require(:user).permit(:name, :email, :password,
    #                               :password_confirmation, :subdomain, :stripe_card_token)
    # end

    def invite_params
      params.require(:invite).permit(:email, :user_group_id, :sender_id, :recipient_id, :token, :subdomain)
    end

  end
end
