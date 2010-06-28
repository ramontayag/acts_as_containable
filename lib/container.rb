class Container < ActiveRecord::Base
	acts_as_ordered_tree
	belongs_to :containable, :polymorphic => true
	before_destroy :destroy_containable
	default_scope :order => "position"
  named_scope :of_type, lambda { |type|
    {:conditions => {:containable_type => type} }
  }

	private

	def destroy_containable
		if containable_type.constantize.exists?(containable_id)
			containable_type.constantize.destroy(containable_id) 
		end
	end
end
