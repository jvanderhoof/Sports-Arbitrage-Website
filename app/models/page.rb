class Page < ActiveRecord::Base
  belongs_to :sport
  belongs_to :betting_site
end
