-- -1 Joker slots
-- Start with a random Resident
-- Residents retrigger once

SMODS.Back {
	key = "mall",
	atlas = "enhancers",
	pos = {x=0,y=1},
	config = {joker_slot = -1},
	loc_vars = function(self, info_queue, back)
		return { vars = { self.config.joker_slot } }
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({ func = function()
			SMODS.add_card({set = 'elle_Resident', seed = "elle_mall_deck", area = G.elle_resident_area})
			
		return true end }))
	end,
	calculate = function(self, back, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.area == G.elle_resident_area then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = back,
			}
		end
	end
}