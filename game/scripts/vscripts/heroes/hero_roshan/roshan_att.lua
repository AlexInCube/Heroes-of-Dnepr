function Stats( keys )
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local cooldown = ability:GetCooldown(level)
	local caster = keys.caster	
	local target = keys.target	
	local damagehero = caster:GetBaseDamageMax()
	local damage = ability:GetLevelSpecialValueFor("DamageTick", ability:GetLevel() - 1)
	local str = keys.str
	local healthhero = caster:GetMaxHealth()
	local health = ability:GetLevelSpecialValueFor("HealthTick", ability:GetLevel() - 1)
	local model = caster:GetModelScale()
	if caster:IsIllusion() == false then
		if ability:GetCooldownTimeRemaining() == 0 then
			caster:ModifyStrength(str)
			caster.Additional_str = (caster.Additional_str or 0) + str
			caster:SetModelScale(model+0.05)
			ability:StartCooldown(60)	
				
		end
	end
end