module UserHelper

	def possessive(name)
		if name.end_with?('s')
			suffix = "'"
		else
			suffix = "'s"
		end
		name + suffix
	end
end

class String
	include UserHelper
end

