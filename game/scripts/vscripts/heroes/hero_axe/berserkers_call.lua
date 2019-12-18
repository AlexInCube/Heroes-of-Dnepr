function BerserkersCall( keys )
	local caster = keys.caster
	local target = keys.target
	
	-- Clear the force attack target
	target:SetForceAttackTarget(nil)

	
	target:MoveToNPC(target)
	-- Set the force attack target to be the caster
	target:SetForceAttackTarget(target)
end

-- Clears the force attack target upon expiration
function BerserkersCallEnd( keys )
	local target = keys.target

	caster:SetForceAttackTarget(nil)
end