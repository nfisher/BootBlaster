class VirtualBoxParser
	def initialize
		reset
	end
	
	def parse_detailed_vminfo(iostream)
		property_set = {}
		iostream.each_line do |line|
			key, value = line.chomp.split('=', 2)
			value = (value[0] == '"') ? value[1...-1] : value
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

