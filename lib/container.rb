class Container < ActiveRecord::Base
  acts_as_ordered_tree
  belongs_to :containable, :polymorphic => true
  default_scope :order => "position"
end
