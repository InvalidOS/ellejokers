ellejokers.Resident {
	key = 'p23',
	pos = { x = 1, y = 1 },
	config = { extra = { } },
	resident_colour = HEX("fd5f55"),
	loc_vars = function(self, info_queue, card)
		return { vars = {
			"#" -- Needed to add a # to the card name
		}, bio_key = G.P_CENTERS.elle_r_elle_cheshire.discovered and self.key.."_chesh" or nil }
	end
}