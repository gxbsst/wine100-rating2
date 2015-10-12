module Refinery
  module Members
    class Member < Refinery::Core::BaseModel
      self.table_name = 'refinery_members'

      attr_accessible :name, :password_digest, :email, :password_cleartext, :builder_id, :last_sign_in_at, :remember_created_at, :current_sign_in_ip, :last_sign_in_ip, :position

      acts_as_indexed :fields => [:name, :password_digest, :email, :password_cleartext, :current_sign_in_ip, :last_sign_in_ip]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
