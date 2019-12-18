function daniil_fat_layer_takedamage(event)
	local damage = event.damagetaken
	local unit = event.unit
	local ability = event.ability
	local target = event.target
	unit.damagetotal = unit.damagetotal+damage
	print(event.damagetotal)
end

function FatLayerShield( event )
	-- Variables
	local target = event.target
	local max_damage_absorb = event.ability:GetLevelSpecialValueFor("shield_damage_block", event.ability:GetLevel() - 1 )
	local shield_size = 75 -- could be adjusted to model scale


	-- Reset the shield
	target.AphoticShieldRemaining = max_damage_absorb

	-- Particle. Need to wait one frame for the older particle to be destroyed
	Timers:CreateTimer(0.01, function() 
		target.ShieldParticle = ParticleManager:CreateParticle("particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_explosion_alliance_wave.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(target.ShieldParticle, 1, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 2, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 4, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 5, Vector(shield_size,0,0))

		-- Proper Particle attachment courtesy of BMD. Only PATTACH_POINT_FOLLOW will give the proper shield position
		ParticleManager:SetParticleControlEnt(target.ShieldParticle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	end)
end

function FatLayerShieldAbsorb( event )
	-- Variables
	local damage = event.DamageTaken
	local unit = event.unit
	local ability = event.ability
	
	-- Track how much damage was already absorbed by the shield
	local shield_remaining = unit.AphoticShieldRemaining
	print("Shield Remaining: "..shield_remaining)
	print("Damage Taken pre Absorb: "..damage)

	-- Check if the unit has the borrowed time modifier
	if not unit:HasModifier("modifier_borrowed_time") then
		-- If the damage is bigger than what the shield can absorb, heal a portion
		if damage > shield_remaining then
			local newHealth = unit.OldHealth - damage + shield_remaining
			print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..shield_remaining)
			unit:SetHealth(newHealth)
		else
			local newHealth = unit.OldHealth			
			unit:SetHealth(newHealth)
			print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..damage)
		end

		-- Reduce the shield remaining and remove
		unit.AphoticShieldRemaining = unit.AphoticShieldRemaining-damage
		if unit.AphoticShieldRemaining <= 0 then
			unit.AphoticShieldRemaining = nil
			unit:RemoveModifierByName("modifier_aphotic_shield")
			print("--Shield removed--")
		end

		if unit.AphoticShieldRemaining then
			print("Shield Remaining after Absorb: "..unit.AphoticShieldRemaining)
			print("---------------")
		end
	end

end

-- Destroys the particle when the modifier is destroyed. Also plays the sound
function EndShieldParticle( event )
	local target = event.target
	target:EmitSound("Hero_Abaddon.AphoticShield.Destroy")
	ParticleManager:DestroyParticle(target.ShieldParticle,false)
end


-- Keeps track of the targets health
function FatLayerShieldHealth( event )
	local target = event.target

	target.OldHealth = target:GetHealth()
end