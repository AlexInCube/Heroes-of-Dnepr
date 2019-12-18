function AphoticShield( event )
	-- Variables
	local target = event.target
	local max_damage_absorb = event.ability:GetLevelSpecialValueFor("damage_absorb", event.ability:GetLevel() - 1 )
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



-- Destroys the particle when the modifier is destroyed. Also plays the sound
function EndShieldParticle( event )
	local target = event.target
	target:EmitSound("Hero_Abaddon.AphoticShield.Destroy")
	ParticleManager:DestroyParticle(target.ShieldParticle,false)
end


-- Keeps track of the targets health
function AphoticShieldHealth( event )
	local target = event.target

	target.OldHealth = target:GetHealth()
end