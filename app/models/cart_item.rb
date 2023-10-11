class CartItem < ApplicationRecord
  after_create :increment_cart_count
  after_destroy :decrement_cart_count
  # after_validation :increment_quantity

  # validates :name, uniqueness: true
  # validates :price, uniqueness: true
  # validates :description, uniqueness: true


  belongs_to :cart


  private

  def increment_cart_count
    cart.increment!(:count)
  end

  def decrement_cart_count
    cart.decrement!(:count)
  end

end
