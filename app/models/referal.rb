class Referal < ActiveRecord::Base
  belongs_to :betting_site
  belongs_to :game
end
