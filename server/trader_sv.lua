lib.callback.register('trader_ped:tradeItems', function(source, item, amount, tradableItem)
    local player = source
    local hasItem = exports.ox_inventory:GetItemCount(player, tradableItem)

    -- Check if the player has the specific tradable item
    if hasItem >= amount then
        -- Check if player can carry the items
        if exports.ox_inventory:CanCarryItem(player, item.itemtoreceive, amount * item.amounttoreceive) then
            -- Remove the tradable item
            if exports.ox_inventory:RemoveItem(player, tradableItem, amount) then
                -- Add the traded items
                exports.ox_inventory:AddItem(player, item.itemtoreceive, amount * item.amounttoreceive)
                return true, nil
            end
        else
            return false, "weight"
        end
    end
    return false, "count"
end)