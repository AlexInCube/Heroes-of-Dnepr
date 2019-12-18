function DealDamage(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local health_damage_pct = ability:GetLevelSpecialValueFor("damage_bonus", ability:GetLevel() - 1) / 100
	local health = caster:GetBaseDamageMax()
	local Talent = caster:FindAbilityByName("special_bonus_unique_phoenix_4")
	if Talent:GetLevel() == 1 then
		health_damage_pct = health_damage_pct + (20/100)
	end
	ApplyDamage({victim = target, attacker = caster, damage = health * health_damage_pct, damage_type = ability:GetAbilityDamageType()})
end