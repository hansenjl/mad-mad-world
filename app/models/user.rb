class User < ActiveRecord::Base
    has_many :starwars, dependent: :destroy
    has_secure_password 
    validates :username, presence: true, uniqueness: { message: "%{value} is already in use.  Please select another or login."}
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true, uniqueness: { message: "%{value} is already in use.  Please select another or login."}

end
