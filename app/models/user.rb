class User < ApplicationRecord

    enum role: { supplier: 0, customer: 1}   
    after_initialize :set_default_role, if: :new_record?

    has_many :items

    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }


    private

    def set_default_role
        self.role ||= :general
    end

    
  end