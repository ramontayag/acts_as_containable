require 'active_record/acts/containable/class_methods'
require 'active_record/acts/containable/instance_methods'

require 'action_controller/acts/containable/config'
require 'action_controller/acts/containable/class_methods'
require 'action_controller/acts/containable/instance_methods'

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Containable)
ActionController::Base.send(:include, ActionController::Acts::Containable)
