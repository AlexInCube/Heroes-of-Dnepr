--[[ ============================================================================================================
	Author: Rook
	Date: January 30, 2015
	Called regularly while Radiance's aura is affecting a unit.  Damages them.
	Additional parameters: keys.AuraDamageInterval and keys.AuraDamagePerSecond
================================================================================================================= ]]
function modifier_item_radiance_datadriven_aura_on_interval_think(keys)
	local damage_to_deal = keys.AuraDamagePerSecond * keys.AuraDamageInterval   --This gives us the damage per interval.
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_MAGICAL,})
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 30, 2015
	Called when Radiance (active) is cast.  Swaps the item to Radiance (inactive).
================================================================================================================= ]]
function item_radiance_datadriven_on_spell_start(keys)
	swap_to_item(keys, "item_radiance_inactive_datadriven")
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 30, 2015
	Called when Radiance (inactive) is cast.  Swaps the item to Radiance (active).
================================================================================================================= ]]
function item_radiance_inactive_datadriven_on_spell_start(keys)
	swap_to_item(keys, "item_radiance_datadriven")
end