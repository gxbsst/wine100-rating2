module Refinery
  module Members
    class Member < Refinery::Core::BaseModel
      self.table_name = 'refinery_members'

      attr_accessible :name, :password, :email, :password_confirmation, :builder_id, :last_sign_in_at, :remember_created_at,
                      :current_sign_in_ip, :last_sign_in_ip, :position, :password_cleartext

      has_secure_password

      acts_as_indexed :fields => [:name, :password_digest, :email, :password_cleartext, :current_sign_in_ip, :last_sign_in_ip]

      validates :name, :presence => true, :uniqueness => true

      validates :password, :presence => true, :on => :create

      before_validation :set_password

      # overwrite password
      def set_password
        self.password = self.password_cleartext
        self.password_confirmation = self.password_cleartext
      end

    end
  end
end
