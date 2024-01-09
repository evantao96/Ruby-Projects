module Referenceable

	module ClassMethods

  		def all
    		@all 
  		end

  		def count
    		@count
  		end

		def last_id
    		@last_id
  		end

  	  	def count=(num)
    		@count = num
  		end

  		def add_id
    		@last_id += 1
  		end

  	  	def find(id)
    		@all.each do |item|
    			if item.id == id 
    				return item 
    			end
    		end
    		return nil
  		end
	end

	module InstanceMethods

		def id
			@id
		end

	end
end
