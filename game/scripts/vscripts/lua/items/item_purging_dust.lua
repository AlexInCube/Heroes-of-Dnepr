item_purging_dust = class({})

LinkLuaModifier("modifier_tallow","lua/items/item_purging_dust",LUA_MODIFIER_MOTION_NONE)

function item_purging_dust:GetIntrinsicModifierName()
	return "modifier_tallow"
end



function item_purging_dust:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCaster()

	-- if caster:GetTeam() == target:GetTeam() then

	caster:Purge(false,true,false,false,false)
	caster:Heal(100,caster)
	-- else

		-- target:Purge(true,false,false,false,false)

	-- end

	self:SetCurrentCharges(self:GetCurrentCharges()-1) --[[Returns:void
	Set the number of charges on this item
	]]

	self:StartCooldown(self:GetCooldown(self:GetLevel()))

	

	caster:EmitSound("omnom")

	if self:GetCurrentCharges() <= 0 then
		self:RemoveSelf()
	end
end

modifier_tallow = class({})


function modifier_tallow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function modifier_tallow:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor( "stats" )
end

function modifier_tallow:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor( "stats" )
end

function modifier_tallow:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor( "stats" )
end

function modifier_tallow:IsHidden()
	return true
end