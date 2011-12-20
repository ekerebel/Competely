class Product < ActiveRecord::Base
    acts_as_indexed :fields => [:fulldescription]
	has_many :prices, :dependent => :destroy
	def fulldescription
    	self.manufacturer + ' ' + self.name + ' ' + self.description
 	 end
end
