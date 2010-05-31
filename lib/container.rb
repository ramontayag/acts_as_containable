class Container < ActiveRecord::Base
	acts_as_ordered_tree
	belongs_to :containable, :polymorphic => true
	default_scope :order => "position"
	before_destroy :destroy_containable

	private

	def destroy_containable
		if containable_type.constantize.exists?(containable_id)
			containable_type.constantize.destroy(containable_id) 
		end
	end
end
