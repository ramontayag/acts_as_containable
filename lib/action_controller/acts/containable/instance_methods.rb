module ActionController
	module Acts
		module Containable  
			module InstanceMethods
				def create
					record = klass.create_in_container(params[:parent_id], params[klass.name.downcase.to_sym])

					respond_to do |f|
						instance_variable_set("@#{klass.name.downcase.singularize}", record)
						if record.valid?
							flash_notice = "You have just created a new #{klass.name}."
							f.html do
								flash[:notice] = flash_notice
								redirect_to record
							end
							f.js do
								flash.now[:notice] = flash_notice
							end
						else
							f.html {render :new}
						end
					end
				end       

				def destroy
					record = klass.send(find_method, params[:id])
					container = record.container

					to = root_path
					to = container.parent.containable if container.parent

					respond_to do |f|
						if record.destroy
							flash[:notice] = "You just deleted the #{klass.name}."
							f.html {redirect_to to}
						else
							flash[:error] = "There was a problem deleting the #{klass.name}. Please try again."
							f.html {redirect_to record}
						end
					end
				end

				# This has only been tested manually.
				def sort
					record = klass.send(find_method, params[:id])
					parent_container = record.container
					parent_container.children.each do |container|
						container.position = params['container'].index(container.id.to_s) + 1
						container.save
					end
					render :nothing => true
				end

				protected

				def klass
					self.class.acts_as_containable_config.model
				end

				def find_method
					find_by_column = self.class.acts_as_containable_config.find_by
					if find_by_column.to_sym == :id
						"find"
					else
						"find_by_#{find_by_column}"
					end
				end

				# Returns the children containers of this record's container.
				def find_child_containers
					record = klass.send(find_method, params[:id])
					container = record.container
					@child_containers ||= container.children
				end
			end
		end
	end
end
