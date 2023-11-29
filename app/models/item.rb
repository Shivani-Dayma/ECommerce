class Item < ApplicationRecord
  searchkick
  belongs_to :user
  belongs_to :category


  end
  
  
  
