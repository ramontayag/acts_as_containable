module ActiveRecord
	module Acts        	
		module Containable   
			module InstanceMethods
        def destroy_with_container
          self.container.destroy && self.destroy
        end

        def contain!(parent_id = 0)
          Container.create(:containable_id => id, :containable_type => self.class.name, :parent_id => parent_id) unless container
        end  
			end # End of InstanceMethods
		end
	end
end             
