module ActionController
  module Acts
    module Containable    
      def self.included(base)
        base.extend(ClassMethods)
      end            

      module ClassMethods
        def acts_as_containable(options={})
          # converts Foo::BarController to 'bar' and FooBarsController to 'foo_bar'
          # and AddressController to 'address'
          options[:model_id] ||= self.to_s.split('::').last.sub(/Controller$/, '').pluralize.singularize.underscore

          @acts_as_containable_config = ActionController::Acts::Containable::Config.new(options)
          include ActionController::Acts::Containable::InstanceMethods
        end

        # Make the @acts_as_containable_config class variable easily
        # accessable from the instance methods.
        def acts_as_containable_config
          @acts_as_containable_config || self.superclass.instance_variable_get('@acts_as_containable_config')
        end
      end                          
    end
  end
end
