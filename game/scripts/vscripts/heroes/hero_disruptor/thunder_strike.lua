--[[Author: YOLOSPAGHETTI
	Date: March 30, 2016
	Gives vision to the caster's team]]
function GiveVisionEnd(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local vision_radius = ability:GetLevelSpecialValueFor("vision_radius", ability:GetLevel() -1)
	local vision_duration = ability:GetLevelSpecialValueFor("vision_duration", ability:GetLevel() -1)
		
	AddFOWViewer(caster:GetTeam(), target:GetAbsOrigin(), vision_radius, vision_duration, false)
end

function ApplyDamageToTarget(keys)
local ability = keys.ability
local ability_level = ability:GetLevel() - 1
local damage = ability:GetLevelSpecialValueFor("damage", ability_level)	
local caster = keys.caster
local target = keys.target

local Talent = caster:FindAbilityByName("special_bonus_unique_disruptor_3")
	if Talent:GetLevel() == 1 then
		damage = damage + 10
	end
local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.ability = ability
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.damage = damage

	ApplyDamage(damage_table)
end