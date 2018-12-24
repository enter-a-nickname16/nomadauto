module UsersHelper

    # Returns the Gravatar for the given user.
    # def gravatar_for(user, options = { size: 50 })
    #     gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #     gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    #     image_tag(gravatar_url, alt: user.name, class: "gravatar")
    # end

    def user_status(user)
      if logged_in?
        content_tag(:span, '', class: 'glyphicon glyphicon-ok color-success')
      else
        'Invitation Pending'
      end
    end

    def logged_in?
      @current_user.nil? and request.subdomain == user.subdomain
    end

end
