class User < ApplicationRecord
    has_secure_password

    has_many :measurements
    has_many :stocks

    validates_presence_of   :first_name, :surname, :email, :phone,
                            :birth_date, :diabetes_discovery_date

    validates :password, length: { minimum: 6 }, presence: true,
                         if: :password

    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
    validates_uniqueness_of :email, case_sensitive: false
    validates_uniqueness_of :phone
    validates_length_of :phone, is: 11
end
