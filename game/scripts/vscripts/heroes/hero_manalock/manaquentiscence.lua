function DealDamage(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local health_damage_pct = ability:GetLevelSpecialValueFor("damage_bonus", ability:GetLevel() - 1) / 100
	local health = caster:GetMana()
	ApplyDamage({victim = target, attacker = caster, damage = health * health_damage_pct, damage_type = ability:GetAbilityDamageType()})
end