LinkLuaModifier( "modifier_windrun_casterlua", "heroes/hero_kirill/modifier_windrun_casterlua.lua", LUA_MODIFIER_MOTION_NONE )

function windrun(keys)
local caster = keys.caster
local ability = keys.ability
local ability_level = ability:GetLevel() - 1
local runduration = ability:GetLevelSpecialValueFor("duration", ability_level)
caster:AddNewModifier(caster, ability, "modifier_windrun_casterlua", {duration = runduration})
end