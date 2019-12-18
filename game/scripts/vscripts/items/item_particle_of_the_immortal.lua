function item_immortal_on_spell_start(keys)
	
	--Reduce the charges left on the item by 1.  Remove the item if there are no charges left.
	local new_charges = keys.ability:GetCurrentCharges() - 1
	if new_charges <= 0 then
		keys.caster:RemoveModifierByNameAndCaster("modifier_skeleton_king_reincarnation_scepter", keys.caster)
		keys.caster:RemoveItem(keys.ability)
	else  --new_charges > 0 
		keys.ability:SetCurrentCharges(new_charges)
	end
end