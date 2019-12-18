item_crystal_focus = class({})

LinkLuaModifier("modifier_crystal_focus","lua/items/item_crystal_focus",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_crystal_focus_prismancy","lua/items/item_crystal_focus",LUA_MODIFIER_MOTION_NONE)

function item_crystal_focus:GetIntrinsicModifierName()
	return "modifier_crystal_focus"
end

modifier_crystal_focus = class({})

function modifier_crystal_focus:DeclareFunctions()
	local func = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS
	}
	return func
end

function modifier_crystal_focus:GetModifierCastRangeBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_cast_range")
end

function modifier_crystal_focus:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_total")
end

function modifier_crystal_focus:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_crystal_focus:GetModifierSpellAmplify_PercentageUnique()
	return self:GetAbility():GetSpecialValueFor("bonus_spell_amp")
end

function modifier_crystal_focus:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end

function modifier_crystal_focus:IsHidden()
	return true
end

modifier_crystal_focus_prismancy = class({})

