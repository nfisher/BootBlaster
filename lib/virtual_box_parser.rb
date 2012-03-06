class VirtualBoxPropertyParser
	def initialize
		reset
	end
	
	def parse_detailed_vminfo(iostream)
		property_set = {}
		iostream.each_line do |line|
			key, value = line.chomp.split('=')
			value = value[1...-1]
			property_set[key] = value
		end
		@vminfo_properties << property_set
	end

	def tell_vminfo(listener)
		@vminfo_properties.each do |vminfo_property|
			listener.receive_virtualbox_vminfo(vminfo_property)
		end
	end

	def reset
		@vminfo_properties = []
	end
end

