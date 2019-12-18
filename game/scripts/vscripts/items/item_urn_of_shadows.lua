--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called when a hero is killed by the player.  Increases the charges on the Urn if the killed hero was not within range.
	Known bugs:
		All players within range with Urns will gain a charge.  It may be that only one charge per kill is supposed to be awarded.
================================================================================================================= ]]
function modifier_item_urn_of_shadows_datadriven_aura_emitter_on_kill(keys)
	--We want to award a charge in the event of a long-range kill as well.  The killed unit will still have the aura modifier
	--on them if they are in range (in which case item_urn_of_shadows_modifier_aura_on_death() would award the killer a charge),
	--but will not have the modifier if they are out of range.
	if not keys.unit:HasModifier("modifier_item_urn_of_shadows_datadriven_aura") then
		item_urn_of_shadows_modifier_aura_on_death(keys)
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called regularly while an enemy has Urn of Shadows' damaging modifier on them.  Damages them.
	Additional parameters: keys.TotalDamage, keys.TotalDuration, and keys.Interval
================================================================================================================= ]]
function modifier_item_urn_of_shadows_datadriven_damage_on_interval_think(keys)
	local damage_to_deal = keys.TotalDamage / keys.TotalDuration   --This gives us the damage per second.
	damage_to_deal = damage_to_deal * keys.Interval   --This gives us the damage per interval.
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_PURE,})
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called regularly while an enemy has Urn of Shadows' healing modifier on them.  Heals them.
	Additional parameters: keys.TotalHeal keys.TotalDuration, and keys.Interval
================================================================================================================= ]]
function modifier_item_urn_of_shadows_datadriven_heal_on_interval_think(keys)
	local amount_to_heal = keys.TotalHeal / keys.TotalDuration   --This gives us the heal per second.
	amount_to_heal = amount_to_heal * keys.Interval   --This gives us the heal per interval.
	keys.target:Heal(amount_to_heal, keys.caster)
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called when a unit with Urn of Shadows' heal modifier takes damage.  Removes the modifier if the damage was caused
	by a hero or tower.
	Additional parameters: keys.Damage
================================================================================================================= ]]
function modifier_item_urn_of_shadows_datadriven_heal_on_take_damage(keys)
	--Remove all Urn healing modifiers if this unit was damaged by an enemy hero or tower.
	if keys.Damage > 0 and (keys.attacker:IsTower() or keys.attacker:IsHero()) then
		keys.unit:RemoveModifierByName("modifier_item_urn_of_shadows_datadriven_heal")
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called when Urn of Shadows is cast.  Applies the healing or damaging modifier, depending on if the targeted unit is
	an ally or enemy.
================================================================================================================= ]]
function item_urn_of_shadows_datadriven_on_spell_start(keys)
	keys.target:EmitSound("DOTA_Item.UrnOfShadows.Activate")
	
	if keys.caster:GetTeam() == keys.target:GetTeam() then   --Apply the healing version of the Urn modifier.
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_urn_of_shadows_datadriven_heal", nil)
	else  --Apply the damaging version of the Urn modifier.
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_urn_of_shadows_datadriven_damage", nil)
	end
	
	
end