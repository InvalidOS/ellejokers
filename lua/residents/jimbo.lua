ellejokers.Resident {
	key = 'jimbo',
	pos = { x = 1, y = 0 },
	config = { extra = { mult_mod = 4, used = false, active = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.mult_mod,
			localize(card.ability.extra.used and "elle_active_used" or "elle_active_available")
		}}
	end,
	in_pool = function (self, args) return false end,
	calculate = function(self, card, context)
		if context.setting_blind then
			juice_card_until(card,function(card)
				return card.ability.extra.active == false and G.STATE ~= G.STATES.ROUND_EVAL
			end)
		end
		
		if context.before and card.ability.extra.active then
			card.ability.extra.active = false
			for i, v in ipairs(G.play.cards) do
				v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.mult_mod
				SMODS.calculate_effect({
					message = localize("k_upgrade_ex"),
					immediate = true
				},v)
			end
			
			return ret
		end

		if context.end_of_round and context.main_eval and card.ability.extra.used then
			card.ability.extra.used = false
			return {
				message = localize("elle_active_refreshed")
			}
		end
	end,
	resident_buttons = {
		{
			can_use = function(self, card) return not card.ability.extra.used and G.STATE == G.STATES.SELECTING_HAND end,
			use = function(self, card)
				card.ability.extra.used = true
				card.ability.extra.active = true
			end,
			scale = 1.6,
			close = true
		}
	},
	resident_colour = G.C.RED,
	resident_visitor = true
}