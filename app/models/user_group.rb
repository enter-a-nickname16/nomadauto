class UserGroup < ActiveRecord::Base
    has_many :invites
end
