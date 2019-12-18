function modifier_item_lifesteal_datadriven_on_orb_impact(keys)
	if keys.target.GetInvulnCount == nil then
		keys.ability:ApplyDataDrivenModifier(keys.attacker, keys.attacker, "modifier_item_lifesteal_datadriven_lifesteal", {duration = 0.03})
	end
end

function ManaBreak( keys )
	local caster = keys.caster
	local ability = keys.ability
	local manaGain = ability:GetLevelSpecialValueFor("manasteal_percent", (ability:GetLevel() - 1))/100
	local damage = caster:GetBaseDamageMax()
	caster:GiveMana(damage * manaGain)
end