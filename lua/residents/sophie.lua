function ellejokers.add_burn(card,count)
	G.E_MANAGER:add_event(Event({func = function()
		card:juice_up(.4,.4)
		card.ability.elle_burns = (card.ability.elle_burns or 0) + (count or 1)
		if card.ability.elle_burns > 3 then SMODS.destroy_cards(card) end
	return true end}))
end

ellejokers.Resident {
	key = 'sophie',
	pos = { x = 3, y = 1 },
	config = { extra = { } },
	resident_colour = HEX("ffcce9"),
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set="Other",key="elle_burn"}
		return {}
	end,
	calculate = function(self, card, context)
		-- Add the mult stuff
		if context.after and SMODS.last_hand_oneshot then
			for i, v in ipairs(context.scoring_hand) do
				ellejokers.add_burn(v)
			end
			return { message = localize("elle_sophie_burn") }
		end
	end
}

-- Hooks
local lpb_hook = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
	lpb_hook(specific_vars,desc_nodes)

	if specific_vars and specific_vars.elle_burns then
		localize{type = 'other', key = specific_vars.elle_burns == 1 and 'elle_card_burn' or 'elle_card_burns', nodes = desc_nodes, vars = {specific_vars.elle_burns, specific_vars.elle_burns+1}}
	end
end

local scoring_numbers = {}

local gmm_hook = Game.main_menu
function Game:main_menu(cc)
	local card = Card(0,0,0,0,nil, G.P_CENTERS.c_base)
	scoring_numbers = SMODS.shallow_copy(card.ability)
	card:remove()
	
	return gmm_hook(self,cc)
end

local cie_hook = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	if scored_card and scored_card.ability and scored_card.ability.elle_burns and scored_card.ability.elle_burns > 0 then
		local base = scoring_numbers[key] or 0

		local burn_mult = 1+scored_card.ability.elle_burns

		amount = (amount-base)*burn_mult+base
	end

	return cie_hook(effect, scored_card, key, amount, from_edition)
end

--[[SMODS.Shader {
	key = 'burn_card',
	path = "burn_card.fs",
	send_vars = function(self, sprite, card) 
		return {
			seed = sprite.unique_val,
			fac = sprite.ability.elle_burns and 1-math.min(math.max(sprite.ability.elle_burns/4,0),1) or 0
		}
	end
}

SMODS.DrawStep {
	key = 'elle_burns',
	order = 80,
	func = function(self, layer)
		if self.ability.elle_burns and self.ability.elle_burns > 0 then
			self.children.center:draw_shader("elle_burn_card", nil, nil, nil, self.children.center)
		end
	end,
	conditions = { vortex = false, facing = 'front' }
}]]