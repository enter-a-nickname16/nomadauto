class User < ActiveRecord::Base

    belongs_to :invite

    has_many :microposts, dependent: :destroy
    has_many :emails
    has_many :plans
    has_many :tasks
    has_many :lists
    has_many :deals
    has_many :projects
    has_many :invitations, :class_name => "Invite",
                  :foreign_key => 'recipient_id'

    has_many :sent_invites, :class_name => "Invite",
                  :foreign_key => 'sender_id'

    has_many :activities

    attr_accessor :remember_token, :activation_token, :reset_token,
                  :stripe_card_token

    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #VALID_SUBDOMAIN_REGEX = /\A[a-z]*\z/

    before_save  :downcase_email
    before_save  :downcase_subdomain
    before_save :remove_whitespace

    validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: true }

    validates :subdomain, presence: true, uniqueness: { case_sensitive: true },
                  length: { maximum: 255 }
                  #format: { with: VALID_SUBDOMAIN_REGEX }


    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true


      # If pro user passes validations (email, password, etc.).
      # then call Stripe and tell Stripe to setup a subscription.
      # upon charging the customer's card.
      # Stripe responds back with customer data.
      # Store customer.id as the customer token and save the token.
      def save_with_subscription
        if valid?
          customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
          self.stripe_customer_token = customer.id
          save!
        end
      end

    # Returns the hash difest of the given string.
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Activates an account.
    def activate
        update_attribute(:activated,        true)
        update_attribute(:activated_at,     Time.zone.now)
    end

    def invite
        update_attribute(:invited,        true)
        update_attribute(:invited_at,     Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # Sets the password reset attributes.
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # Sends password reset email.
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # Defines a proto-feed.
    # See "Following users"
    def feed
        Micropost.where("user_id = ?", id)
    end

    def user_projects
        projects_array = []
        invitelist.each do |user|
            projects_array << user.projects.map(&:id)
            puts '*' * 88
        end
        Project.find(projects_array)
    end

    def user_users
        users_array = []
        invitelist.each do |user|
            users_array << user.tap(&:name)
            puts '*' * 88
        end
    end

    def invitelist
        User.where(:subdomain => subdomain)
    end

    def company_name
        User.find_by_name(request.subdomain)
    end

    private

        # Converts email to all lower-case.
        def downcase_email
          self.email = email.downcase
        end

        # Converts subdomain to alll lower-case
        def downcase_subdomain
          self.subdomain = subdomain.downcase
        end

        def remove_whitespace
          self.subdomain = self.subdomain.gsub(/\s+/, "")
        end


        # Creates and assigns the activation token and digest.
        def create_activation_digest
          self.activation_token  = User.new_token
          self.activation_digest = User.digest(activation_token)
        end

end
