class WishlistItem < ApplicationRecord
  belongs_to :wishlist

  after_create :increment_wishlist_count
  after_destroy :decrement_wishlist_count

private
def increment_wishlist_count
  wishlist.increment!(:count)
end

def decrement_wishlist_count
  wishlist.decrement!(:count)
end

end
