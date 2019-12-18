function item_magic_exilir_start(keys)
	
	--Reduce the charges left on the item by 1.  Remove the item if there are no charges left.
	local new_charges = keys.ability:GetCurrentCharges() - 1
	if new_charges <= 0 then
		keys.caster:RemoveItem(keys.ability)
	else  --new_charges > 0 
		keys.ability:SetCurrentCharges(new_charges)
	end
end