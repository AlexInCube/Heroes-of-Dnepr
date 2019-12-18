modifier_windrun_casterlua = class({})

function modifier_windrun_casterlua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }

    return funcs
end

function modifier_windrun_casterlua:OnCreated( kv )
    self.bonusmovespeed = self:GetAbility():GetSpecialValueFor("movespeed_bonus_pct")
    self.bonusevasion = self:GetAbility():GetSpecialValueFor("evasion_pct_tooltip")
	
end



function modifier_windrun_casterlua:GetModifierEvasion_Constant( params )
	
    return self.bonusevasion
end

function modifier_windrun_casterlua:GetModifierMoveSpeedBonus_Percentage( params )
    return self.bonusmovespeed
end

function modifier_windrun_casterlua:IsBuff()
    return true
end

function modifier_windrun_casterlua:IsHidden()
    return false
end

function modifier_windrun_casterlua:IsPurgable()
	return true
end

function modifier_windrun_casterlua:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf"
end

function modifier_windrun_casterlua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end