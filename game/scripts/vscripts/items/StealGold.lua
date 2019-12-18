function StealGold(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local Gold = 0
	local gold_damage = target:GetGold()
	
	if target:TriggerSpellAbsorb(ability) then return end
	target:TriggerSpellReflect(ability)
	
	target:EmitSound("DOTA_Item.Hand_Of_Midas")
	local midas_particle = ParticleManager:CreateParticle("particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)	
	ParticleManager:SetParticleControlEnt(midas_particle, 1, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), false)
	
		Gold = gold_damage
		
		local Steal = gold_damage * (-1)
		
		target:ModifyGold(Steal, false, 0)
		caster:ModifyGold(Gold, false, 0)
end