local config = require 'shared.config'
local stolenSigns = {}

-- Register server event for stealing signs
RegisterNetEvent('sign_robbery:stealSign', function(signItem)
    local source = source

    -- Anti-spam logic
    if stolenSigns[source] and (os.time() - stolenSigns[source]) < 5 then
        -- Player is trying to spam the event
        return
    end

    -- Validate that the signItem is a valid sign type
    local validSignItem = false
    for _, sign in ipairs(config.signProps) do
        if sign.item == signItem then
            validSignItem = true
            break
        end
    end

    if not validSignItem then
        print("Invalid sign item received from player: " .. tostring(signItem))
        return
    end

    -- Check if the player needs to have an item (we don't consume it)
    if config.requireItemForRobbery then
        local hasItem = exports.ox_inventory:GetItemCount(source, config.robberyItem)
        if hasItem <= 0 then
            return -- Player doesn't have the required item
        end
    end

    -- Check if player can carry the stolen sign
    if exports.ox_inventory:CanCarryItem(source, signItem, 1) then
        -- Add the specific stolen sign type to player's inventory
        exports.ox_inventory:AddItem(source, signItem, 1)

        -- Add player to cooldown
        stolenSigns[source] = os.time()

        -- Notify player
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Sign Robbery',
            description = 'You stole a ' .. signItem:gsub("_", " ") .. '!',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Sign Robbery',
            description = 'You cannot carry any more signs.',
            type = 'error'
        })
    end
end)

-- Clear player data when they disconnect
AddEventHandler('playerDropped', function()
    local source = source
    if stolenSigns[source] then
        stolenSigns[source] = nil
    end
end)

-- Clean up data when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        stolenSigns = {}
    end
end)