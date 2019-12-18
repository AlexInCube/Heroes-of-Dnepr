function swap_to_item(keys, ItemName)
	for i=0, 5, 1 do 
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			keys.caster:AddItem(CreateItem("item_dummy", keys.caster, keys.caster))
		end
	end
	
	keys.caster:RemoveItem(keys.ability)
	keys.caster:AddItem(CreateItem(ItemName, keys.caster, keys.caster)) 
	
	for i=0, 5, 1 do  
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_datadriven" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end
end


function item_power_treads_strength_datadriven_on_spell_start(keys)
	swap_to_item(keys, "item_power_treads_agility_datadriven")
end



function item_power_treads_agility_datadriven_on_spell_start(keys)
	swap_to_item(keys, "item_power_treads_intelligence_datadriven")
end



function item_power_treads_intelligence_datadriven_on_spell_start(keys)
	swap_to_item(keys, "item_power_treads_strength_datadriven")
end