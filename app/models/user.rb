class User < ApplicationRecord
    attr_reader :password
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :password_digest, presence: { 
        message: "^Password cannot be blank"
     }
    validates :password, length: { minimum: 6, allow_nil: true }


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end
end
