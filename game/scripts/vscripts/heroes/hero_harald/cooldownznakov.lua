function Cooldown(keys)
local ability = keys.ability
local caster = keys.caster
local ability1 = caster:FindAbilityByName("lina_dragon_slave_datadriven") 
local ability2 = caster:FindAbilityByName("lycan_howl") 
local ability3 = caster:FindAbilityByName("drow_ranger_wave_of_silence") 
local ability4 = caster:FindAbilityByName("skeleton_king_hellfire_blast") 
local ability5 = caster:FindAbilityByName("alchemist_acid_spray") 

if ability1 ~= ability then
ability1:UseResources(false,false,true) 
end

if ability2 ~= ability then
ability2:UseResources(false,false,true) 
end

if ability3 ~= ability then
ability3:UseResources(false,false,true) 
end

if ability4 ~= ability then
ability4:UseResources(false,false,true) 
end

if ability5 ~= ability then
ability5:UseResources(false,false,true) 
end


void UseResources(bool bMana, bool bGold, bool bCooldown)