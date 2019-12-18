function DeathPact( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local duration = ability:GetLevelSpecialValueFor( "duration" , ability:GetLevel() - 1 )

	-- Health Gain
	local health_gain_pct = ability:GetLevelSpecialValueFor( "str" , ability:GetLevel() - 1 ) * 0.01
	local target_health = caster:GetAgility()
	local health_gain = math.floor(target_health * health_gain_pct)

	local health_modifier = "modifier_dilan_bonus_agility"
	ability:ApplyDataDrivenModifier(caster, caster, health_modifier, { duration = duration })
	caster:SetModifierStackCount( health_modifier, ability, health_gain )

	
end
