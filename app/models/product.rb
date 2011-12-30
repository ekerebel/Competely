class Product < ActiveRecord::Base
    acts_as_indexed :fields => [:fulldescription]
    belongs_to :user
    belongs_to :category
	has_many :prices, :dependent => :destroy
	has_many :productpurchases, :dependent => :destroy
	def fulldescription
    	self.manufacturer + ' ' + self.name + ' ' + self.description
 	 end
 	validates :category_id, :presence => true
 	
 	def price
 		12
 	end
 	
end
