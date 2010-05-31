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
              self.new(attributes).tap do |resource|
                if resource.save
                  resource.contain!(parent_id.to_i)
                else
                  Rails.logger.error "There was a problem with the resource"
                end
                resource
              end
            end    
          EOV
        end
      end   
    end
  end
end           
