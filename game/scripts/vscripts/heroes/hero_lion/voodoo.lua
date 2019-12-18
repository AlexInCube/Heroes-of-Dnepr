LinkLuaModifier("modifier_voodoo_lua", "heroes/hero_lion/modifiers/modifier_voodoo_lua.lua", LUA_MODIFIER_MOTION_NONE)

--[[Author: Pizzalol
	Date: 27.09.2015.
	Checks if the target is an illusion, if true then it kills it
	otherwise it applies the hex modifier to the target]]


function voodoo_start( keys )
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local target = keys.target

	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)
	local Talent = caster:FindAbilityByName("special_bonus_unique_earthshaker_2")
	
	if Talent:GetLevel() == 1 then
		duration = duration + 1.5
	end
	if caster:IsIllusion() == false then
		if ability:GetCooldownTimeRemaining() == 0 then
			if target:IsIllusion() then
				target:ForceKill(true)
			else
				target:AddNewModifier(caster, ability, "modifier_voodoo_lua", {duration = duration})
				target:EmitSound("Hero_Lion.Hex.Target")
			end
		end
	end
end

function voodoo_start_Cooldown( keys )
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local cooldown = ability:GetCooldown(level)
	local caster = keys.caster	
	local modifierName = "modifier_versuta_dog"
	
	
	if caster:IsIllusion() == false then
		if ability:GetCooldownTimeRemaining() == 0 then
			ability:StartCooldown(cooldown)	
			
		end
	end
end