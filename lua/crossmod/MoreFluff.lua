if not FLUFF.is_rewrite then return end -- Only continue if playing with the MoreFluff rewrite

SMODS.Atlas {
	key = "morefluff",
	path = "crossmod/morefluff.png",
	px = 71,
	py = 95
}

FLUFF.Colour({
	key = "jessblue",
	name = "col_jessblue",
	atlas = "morefluff",
	pos = { x = 1, y = 1 },
	config = {
		upgrade_rounds = 1,
        enhancement = "m_elle_jess"
	},
	slime_desc_icon = {
		atlas = "elle_cornericons",
		pos = {x=1,y=0}
	},
	mf_art_credit = "Multi + ellestuff."
})

FLUFF.Colour({
	key = "ellepink",
	name = "col_ellepink",
	atlas = "morefluff",
	pos = { x = 2, y = 1 },
	config = {
		upgrade_rounds = 1,
        enhancement = "m_elle_slime"
	},

	mf_art_credit = "Multi + ellestuff."
})

SMODS.Consumable({
	set = "Rotarot",
	key = "rot_lucid",
	pos = { x = 0, y = 0 },
	config = {
		max_highlighted = 2,
		mod_conv = "m_elle_lime",
	},
	cost = 3,
	atlas = "morefluff",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_elle_lime

		return { vars = { card.ability.max_highlighted } }
	end,
})

SMODS.Consumable({
	set = "Rotarot",
	key = "rot_jess",
	pos = { x = 1, y = 0 },
	config = {
		max_highlighted = 4,
		mod_conv = "m_elle_less",
	},
	cost = 3,
	atlas = "morefluff",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_elle_less

		return { vars = { card.ability.max_highlighted } }
	end,
})

SMODS.Enhancement {
	key = 'lime',
	atlas = 'morefluff',
	pos = { x = 0, y = 1 },
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
	end
}

SMODS.Enhancement {
	key = 'less',
	pos = { x = 1, y = 0 },
	config = { extra_slots_used = -.5, extra = {handper = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.handper, 1+card.ability.extra_slots_used }, key = card.fake_card and 'm_elle_less2' }
	end,
	display_size = { w = 71 * 0.7, h = 95 * 0.7 },
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local count = 0
			
			for i, v in ipairs(G.hand.cards) do
				if SMODS.has_enhancement(v, "m_elle_less") then count = count + 1 end
			end

			return {
				mult = count*card.ability.extra.handper
			}
		end
	end
}

ellejokers.Resident {
	key = "triangle",
	atlas = "morefluff",
	pos = {x=0,y=2},
	resident_colour = HEX('fd5f55'),
	mf_art_credit = "notmario"
}