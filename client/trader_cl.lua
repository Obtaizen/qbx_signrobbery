--- this was taken from a old script of mine so i dont have to rewrite the trading logic again 
---
local config = require 'shared.config'
local created = false

CreateThread(function()
    if not created then
        created = true
        createTraderPed()
    end
end)

function createTraderPed()
    local pedModel = config.traderPed.pedmodel
    local coords = config.traderPed.coords
    
    local success = lib.requestModel(pedModel)
    if not success then
        print('Failed to load trader ped model. Retrying in 5 seconds...')
        Wait(5000)
        return createTraderPed()
    end
    
    local ped = CreatePed(4, GetHashKey(pedModel), coords.x, coords.y, coords.z, coords.w, false, true)
    if not DoesEntityExist(ped) then
        print('Failed to create trader ped. Retrying...')
        SetModelAsNoLongerNeeded(pedModel)
        Wait(2000)
        return createTraderPed()
    end
    
    SetEntityHeading(ped, coords.w)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetModelAsNoLongerNeeded(pedModel)
    
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'trade_materials',
            icon = 'fas fa-recycle',
            label = 'Trade Items',
            onSelect = function()
                openTradeSelectionMenu()
            end,
            canInteract = function()
                return true
            end,
        }
    })
end

--[[ Thanks copilot for doing this function for me as my brain cant think of all this %a [%W_ ] or what ever is this bull shit (if you are asking what is this for is to)
write better item names and text by example my item name is stolen_sign we dont type "trade stolen_sign" but we make it type "trade stolen sign" instead   ]]
function formatItemName(itemName)
    -- Remove special characters and replace underscores with spaces
    local formatted = itemName:gsub("%*", "")
    formatted = formatted:gsub("_", " ")

    -- Capitalize first letter of each word
    formatted = formatted:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)

    return formatted
end

function openTradeSelectionMenu()
    local options = {}

    -- Check if player has any of the tradable items
    local hasItems = false
    for _, itemName in ipairs(config.itemRequiredForTrade) do
        local count = exports.ox_inventory:Search('count', itemName)
        if count > 0 then
            hasItems = true
            -- Add each tradable item as an option
            options[#options + 1] = {
                title = ('Trade %s'):format(formatItemName(itemName)),
                description = ('You have %d %s'):format(count, formatItemName(itemName)),
                onSelect = function()
                    openTradeMenu(itemName)
                end,
            }
        end
    end

    -- If player has no tradable items, show notification instead
    if not hasItems then
        lib.notify({
            id = 'trade_error',
            title = 'No tradable items',
            description = 'You don\'t have any items that can be traded.',
            type = 'error'
        })
        return
    end

    lib.registerContext({
        id = 'trade_selection_menu',
        title = 'Select Item to Trade',
        options = options
    })

    lib.showContext('trade_selection_menu')
end

function openTradeMenu(tradableItem)
    local options = {}

    for _, item in ipairs(config.tradableItems) do
        options[#options + 1] = {
            title = formatItemName(item.itemtoreceive),
            description = ('Trade 1 %s for %s %s'):format(
                formatItemName(tradableItem),
                item.amounttoreceive,
                formatItemName(item.itemtoreceive)
            ),
            onSelect = function()
                local count = exports.ox_inventory:Search('count', tradableItem)
                if count > 0 then
                    openInputDialog(item, count, tradableItem)
                else
                    lib.notify({
                        id = 'trade_error',
                        title = 'Trade Failed',
                        description = ('You don\'t have any %s to trade.'):format(formatItemName(tradableItem)),
                        type = 'error'
                    })
                end
            end,
        }
    end

    lib.registerContext({
        id = 'trade_menu',
        title = ('Trade %s'):format(formatItemName(tradableItem)),
        options = options
    })

    lib.showContext('trade_menu')
end

function openInputDialog(item, maxCount, tradableItem)
    local input = lib.inputDialog('Select Amount', {
        {
            type = 'slider',
            label = 'Amount',
            description = ('Trade %s for %s (Max: %s)'):format(
                formatItemName(tradableItem),
                formatItemName(item.itemtoreceive),
                maxCount
            ),
            default = 1,
            min = 1,
            max = maxCount
        }
    })

    if input then
        local amount = input[1]
        executeTradeTransaction(item, amount, tradableItem)
    end
end

function executeTradeTransaction(item, amount, tradableItem)
    lib.callback('trader_ped:tradeItems', false, function(success, reason)
        if success then
            lib.notify({
                id = 'trade_success',
                title = 'Trade Successful',
                description = ('You received %s %s'):format(
                    amount * item.amounttoreceive,
                    formatItemName(item.itemtoreceive)
                ),
                type = 'success'
            })
        else
            if reason == "weight" then
                lib.notify({
                    id = 'trade_error',
                    title = 'Trade Failed',
                    description = 'You cannot carry that much weight',
                    type = 'error'
                })
            else
                lib.notify({
                    id = 'trade_error',
                    title = 'Trade Failed',
                    description = 'You don\'t have enough tradable items',
                    type = 'error'
                })
            end
        end
    end, item, amount, tradableItem)
end