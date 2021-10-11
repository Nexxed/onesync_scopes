local scopes = {}


--[[
    this handler prevents the `scopes` table from getting clogged-up
    with dead/disconnected players
]]
AddEventHandler("playerDropped", function()
    local source = source

    -- unset the scope for this source
    scopes[source] = nil

    -- loop through every stored player scope and remove any occurrences of this source
    for player, players in pairs(scopes) do

        -- loop through every player in this players' scope
        for index, p in ipairs(players) do

            -- if the source is in the players' scope
            if(source == p) then

                -- remove the value from the table
                table.remove(scopes[player], index)

            end
        end
    end
end)


--[[
    this event gets fired when a player enters anothers scope
]]
AddEventHandler("playerEnteredScope", function(data)
    local source = tonumber(data["for"])
    local player = tonumber(data.player)

    -- create a scopes table for this source player, if doesn't exist
    if(not scopes[source]) then
        scopes[source] = {}
    end

    scopes[source][#scopes[source] + 1] = player
end)


--[[
    same as the above, but for leaving the scope instead
]]
AddEventHandler("playerLeftScope", function(data)
    local source = tonumber(data["for"])
    local player = tonumber(data.player)

    -- create a scopes table for this source player, if doesn't exist
    if(not scopes[source]) then
        scopes[source] = {}
    end

    -- loop through every player in scope and remove them from the table
    for index, p in ipairs(scopes[source]) do
        if(p == player) then
            table.remove(scopes[source], index)
            break
        end
    end
end)


--[[
    this export returns true/false based on whether or not
    the two given players are in scope of eachother
]]
exports("IsPlayerInScope", function(source, player)

    -- if a scope object doesn't exist, return false
    if(not scopes[source]) then
        return false
    end

    -- loop through every player in p1's scope and find one matching the given player
    for _, p in ipairs(scopes[source]) do
        if(p == player) then
            return true
        end
    end

    -- wasn't found, return false
    return false
end)


--[[
    this one returns a table of players within a given players' scope
]]
exports("GetPlayersInScope", function(source)

    -- if a scope object doesn't exist, return false
    if(not scopes[source]) then
        return false
    end

    -- return a table (array) of players in scope of the given player
    return scopes[source]
end)


--[[
    simple function for calling TriggerClientEvent for all players within a scope
]]
exports("TriggerEventInPlayerScope", function(eventName, source, ...)

    -- if a scope object doesn't exist, return false
    if(not scopes[source]) then
        return false
    end

    -- send event to every player in scope of source
    for _, player in ipairs(scopes[source]) do
        TriggerClientEvent(eventName, player, table.unpack({...}))
    end

    -- return a true-y value (in this case, every player in scope)
    return scopes[source]
end)


--[[
    simple function for calling TriggerLatentClientEvent for all players within a scope
]]
exports("TriggerLatentEventInPlayerScope", function(eventName, source, bps, ...)

    -- if a scope object doesn't exist, return false
    if(not scopes[source]) then
        return false
    end

    -- send latent event to every player in the scope of source
    for _, player in ipairs(scopes[source]) do
        TriggerLatentClientEvent(eventName, player, bps, table.unpack({...}))
    end

    -- return a true-y value (in this case, every player in scope)
    return scopes[source]
end)
