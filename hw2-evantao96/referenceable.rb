module Referenceable

	module ClassMethods

		def self.last_id
    		@last_id
  		end

  		def self.count
    		@count
  		end

  		def self.all
    		@all 
  		end

  	  	def self.add_count
    		@count += 1
  		end

  		def self.add_id
    		@last_id += 1
  		end

  	  	def self.find(id)
    		if id <= @last_id
      			return @all[id]
    		else
      			return nil 
    		end
  		end
	end
end
