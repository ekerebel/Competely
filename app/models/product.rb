class Product < ActiveRecord::Base
	has_many :prices, :dependent => :destroy
end
