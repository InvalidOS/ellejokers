ellejokers.Resident {
	key = 'mint',
	pos = { x = 4, y = 0 },
	loc_vars = function(self, info_queue, card)
		local colours = {}
		
		for i = 1, 6 do
			colours[#colours+1] = mix_colours(self.resident_colour,G.P_CENTERS.elle_r_elle_sarah.resident_colour,(i-1)/5)
		end
		
		return {
			vars = { colours = colours },
			bio_key = G.P_CENTERS.elle_r_elle_cheshire.discovered and self.key.."_chesh" or nil
		}
	end,
	config = { extra = { } },
	resident_colour = HEX("65e6d4"),
	in_pool = function (self, args) return false end
}