class Category < ApplicationRecord
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
