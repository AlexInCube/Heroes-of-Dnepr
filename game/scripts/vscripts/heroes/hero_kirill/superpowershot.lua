function initialize(keys)
dmgpercent = 0.0
end

function powershot_charge( keys )
	local ability = keys.ability
	
	local intdmg = ability:GetLevelSpecialValueFor("damage_per_interval", ability:GetLevel() - 1)
	-- Fail check
	if not dmgpercent then
		dmgpercent = 0.0
	end
	dmgpercent = dmgpercent + intdmg
	print(dmgpercent)
end

function LaunchArrow( keys )
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local target = keys.target_points[1]
	
	-- Parameters
	local caster_loc = caster:GetAttachmentOrigin(DOTA_PROJECTILE_ATTACHMENT_ATTACK_1)
	local cast_direction = (target - caster_loc):Normalized()
	local arrow_particle = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
	local arrow_speed = ability:GetLevelSpecialValueFor("arrow_speed", ability_level)
	local arrow_width = ability:GetLevelSpecialValueFor("arrow_width", ability_level)
	local vision_radius = ability:GetLevelSpecialValueFor("arrow_vision", ability_level)
	local arrow_amount = ability:GetLevelSpecialValueFor("arrow_amount", ability_level)


	-- Arrow projectile setup
	local arrow_projectile = {
		Ability				= ability,
		EffectName			= arrow_particle,
		vSpawnOrigin		= caster_loc,
		fDistance			= 1200,
		fStartRadius		= arrow_width,
		fEndRadius			= arrow_width,
		Source				= caster,
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
	--	iUnitTargetFlags	= ,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	--	fExpireTime			= ,
		bDeleteOnHit		= true,
		vVelocity			= cast_direction * arrow_speed,
		bProvidesVision		= false,
		iVisionRadius		= vision_radius,
		iVisionTeamNumber	= caster:GetTeamNumber(),
	}

	-- Determine arrow directions
	local arrow_direction
	local constantangle = 360/arrow_amount
	local first_angle = 0 * (arrow_amount - 1) / 2
	for i = 1, arrow_amount do
		arrow_direction = (RotatePosition(caster_loc, QAngle(0, first_angle + (i-1) * constantangle, 0), target) - caster_loc):Normalized()
		
		arrow_projectile.vVelocity = Vector(arrow_direction.x, arrow_direction.y, 0) * arrow_speed
		ProjectileManager:CreateLinearProjectile(arrow_projectile)
	end
end

--[[Calculates the distance traveled by the arrow, then applies damage and stun according to calculations]]
function ArrowHit( keys )

	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local ability_damage = ability:GetAbilityDamage()
	if not target:HasModifier("modifier_superpowershot_checker") then
	-- Initializing the damage table
	ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_superpowershot_checker", nil)
	local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.ability = ability	
	
	-- Arrow
	local arrow_damage = ability:GetLevelSpecialValueFor("arrow_damage", ability_level) * dmgpercent
	print("Arrowdamage",arrow_damage)
	
	damage_table.damage = arrow_damage
	ApplyDamage(damage_table)
	end
end

