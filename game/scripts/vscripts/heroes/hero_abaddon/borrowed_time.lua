function BorrowedTimeActivate( event )
	-- Variables
	local caster = event.caster
	local ability = event.ability
	local threshold = ability:GetLevelSpecialValueFor( "hp_threshold" , ability:GetLevel() - 1  )
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local dur = ability:GetLevelSpecialValueFor( "duration" , ability:GetLevel() - 1  )
	
	-- Apply the modifier
	if caster:GetHealth() < 400 and ability:GetCooldownTimeRemaining() == 0 then
		BorrowedTimePurge( event )
		ability:ApplyDataDrivenModifier( caster, caster, "modifier_invisible", { duration = dur })
		ability:StartCooldown( cooldown )
		caster:Stop()
		
	local target = event.target
	local ability = event.ability	
	local radius = 1
	local player = caster:GetPlayerID()
		local unit_name = caster:GetUnitName()
		local duration = 5
		local health = caster:GetHealth()
		-- Creates both doppelgangers
		for j=0,0 do
			local rand_distance = 1
			local origin = caster:GetAbsOrigin() + RandomVector(rand_distance)
			local outgoingDamage
			local incomingDamage

			-- Sets the outgoing and incoming damage values for the doppelgangers
			if j==0 then
				outgoingDamage = 100
				incomingDamage = 100
			end
	
			-- handle_UnitOwner needs to be nil, else it will crash the game.
			local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
			illusion:SetPlayerID(caster:GetPlayerID())
			illusion:SetControllableByPlayer(player, false)
	
			-- Level Up the unit to the casters level
			local casterLevel = caster:GetLevel()
			for i=1,casterLevel-1 do
				illusion:HeroLevelUp(false)
			end

			-- Set the skill points to 0 and learn the skills of the caster
			--illusion:SetAbilityPoints(0)
			--for abilitySlot=0,15 do
				--local ability = caster:GetAbilityByIndex(abilitySlot)
				--if ability ~= nil then 
				--	local abilityLevel = ability:GetLevel()
				--	local abilityName = ability:GetAbilityName()
				--	local illusionAbility = illusion:FindAbilityByName(abilityName)
				--	illusionAbility:SetLevel(abilityLevel)
			--	end
			--end

			-- Recreate the items of the caster
			for itemSlot=0,5 do
				local item = caster:GetItemInSlot(itemSlot)
				if item ~= nil then
					local itemName = item:GetName()
					local newItem = CreateItem(itemName, illusion, illusion)
					illusion:AddItem(newItem)
					local current_item = keys.caster:GetItemInSlot(i)
					if current_item ~= nil then
					if current_item:GetName() == "item_courier" then
					keys.caster:RemoveItem(current_item)
					end
					end
				end
			end

			-- Set the unit as an illusion
			-- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle
			illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
	
			-- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
			illusion:MakeIllusion()
			illusion:SetHealth(health)
			illusion:RemoveAbility("phantom_lancer_phantom_edge")
		illusion:RemoveAbility("mirage_lastchance")
		illusion:RemoveAbility("mirage_bait")
		illusion:RemoveAbility("mirage_ulti")
		illusion:SetAbilityPoints(0)
		for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local current_item = illusion:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_courier" then
				illusion:RemoveItem(current_item)
			end
		end
	end
	end
end
end


--[[
	Author: Noya
	Date: 9.1.2015.
	Heals for twice the damage taken
]]
function BorrowedTimeHeal( event )
	-- Variables
	local damage = event.DamageTaken
	local caster = event.caster
	local ability = event.ability
	
	caster:Heal(damage*2, caster)
end

function BorrowedTimePurge( event )
	local caster = event.caster

	print("stronk dispel")

	-- Strong Dispel
	local RemovePositiveBuffs = false
	local RemoveDebuffs = true
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = true
	local RemoveExceptions = false
	caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end