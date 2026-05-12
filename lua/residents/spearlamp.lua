-- Add lamp variants here :3
ellejokers.lamps = {
	{
		key_suffix = "_vivi",
		icon = { atlas = "elle_cornericons", pos = {x=1,y=1} },
		crossover = {
			set = "Other", key = "elle_crossover", specific_vars = {"Reverie","@critterror.bsky.social"},
			slime_desc_icon = { atlas = "elle_cornericons", pos = {x=1,y=1} }
		},
		badge = elle_badges.friends
	},
	{
		key_suffix = "_jess",
		icon = { atlas = "elle_cornericons", pos = {x=1,y=0} },
		crossover = {
			set = "Other", key = "elle_crossover", specific_vars = {"Jess","@soup587.bsky.social"},
			slime_desc_icon = { atlas = "elle_cornericons", pos = {x=1,y=0} }
		},
		badge = elle_badges.poly
	},
	{
		key_suffix = "_drago",
		icon = { atlas = "elle_cornericons", pos = {x=0,y=1} },
		crossover = {
			set = "Other", key = "elle_crossover", specific_vars = {"Drago","@dragothedemon.bsky.social"},
			slime_desc_icon = { atlas = "elle_cornericons", pos = {x=0,y=1} }
		},
		badge = elle_badges.friends
	}
}

ellejokers.Resident {
	key = 'spearlamp',
	atlas = 'lamps',
	pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, card)
		local lamp = ellejokers.lamps[card.ability.extra.variant-1] or {}
		
		info_queue[#info_queue+1] = lamp.crossover

		card.config.center.slime_desc_icon = lamp.icon
		
		return {
			vars = { },
			key = self.key..(lamp.key_suffix or ""),
			bio_key = card.ability.extra.variant>1 and self.key..(ellejokers.mod_data.config.nsfw and "_cameo_nsfw" or "_cameo") or nil
		}
	end,
	config = { extra = { variant = 1 } },
	resident_colour = HEX("81cefd"),
	set_ability = function(self, card, initial, delay_sprites)
		-- 1 in 5 chance of silly lamp
		if pseudorandom("elle_do_lamp_tf",1,5)==1 then card.ability.extra.variant = pseudorandom("elle_lamp_tf",1,#ellejokers.lamps)+1 end
		if not slimeutils.card_obscured(card) then
			card.children.center:set_sprite_pos({x = card.ability.extra.variant-1, y = ellejokers.mod_data.config.nsfw and 1 or 0})
	end end,
	add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.variant ~= 1 then check_for_unlock({type = "elle_lamp"}) end
	end,
	update = function(self, card, dt)
		if not slimeutils.card_obscured(card) then
			card.children.center:set_sprite_pos({x = card.ability.extra.variant-1, y = ellejokers.mod_data.config.nsfw and 1 or 0})
	end end
}