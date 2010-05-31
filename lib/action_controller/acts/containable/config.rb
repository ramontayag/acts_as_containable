module ActionController
  module Acts
    module Containable   
      class Config
        attr_reader :model
        attr_reader :find_by
        attr_reader :model_id

        def initialize(options={})
          @model_id = options[:model_id]
          @find_by = options[:find_by] || :id
          @model = model_id.to_s.camelize.constantize
        end

        def model_name
          @model_id.to_s
        end
      end    
    end
  end
end
