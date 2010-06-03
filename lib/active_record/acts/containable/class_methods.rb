module ActiveRecord
  module Acts        	
    module Containable   
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_containable
          class_eval <<-EOV
            has_one :container, :as => :containable, :dependent => :delete
            include ActiveRecord::Acts::Containable::InstanceMethods

            def self.create_in_container(parent_id, attributes = {}) 
              record = self.create(attributes)
              record.contain!(parent_id.to_i) if record.valid?
              record
            end    
          EOV
        end
      end   
    end
  end
end           
