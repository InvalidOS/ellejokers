ellejokers.Resident {
	key = 'p41',
	pos = { x = 2, y = 1 },
	config = { extra = { } },
	resident_colour = HEX("40aeff"),
	loc_vars = function(self, info_queue, card)
		return { vars = {
			"#" -- Needed to add a # to the card name
		}, bio_key = G.P_CENTERS.elle_r_elle_cheshire.discovered and self.key.."_chesh" or nil }
	end
}