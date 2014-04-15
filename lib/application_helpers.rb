module Possessive
	def possessive
		if self.end_with?('s')
			suffix = "'"
		else
			suffix = "'s"
		end
	self + suffix
end


class String
	include Possessive
end
