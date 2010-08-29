class UserBettingSite < ActiveRecord::Base
  belongs_to :user
  belongs_to :betting_site
end
