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
    		if id <= @last_id
      			return @all[id]
    		else
      			return nil 
    		end
  		end
	end

	module InstanceMethods

		def id
			@id
		end

	end
end
