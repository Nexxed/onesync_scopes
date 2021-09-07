# OneSync Scopes
A OneSync Infinity resource that tracks players in scopes of others and provides extra networking utilities for compatible scripts.

As an example scenario for why this resource can help you, is when you need to network an animation (via events) for a player so that others within their scope (or nearby) can see it.

Instead of looping through your entire servers' player table (and calculating distance and so on...) you'd just call one function and your desired event reaches all relevant players, which is far more efficient than sending the event to all players or calculating distance!

# Requirements:
- FXServer running OneSync Infinity

# Documentation

## `IsPlayerInScope`
This function returns true or false depending on if the two given players are in scope of eachother.

Example:
```lua
local scopes = exports.onesync_scopes
local inScope = scopes:IsPlayerInScope(player1, player2)

print(inScope)
-- returns true if both players are within scope of eachother
```

## `GetPlayersInScope`
This one returns a table (array) of players that are in scope of the given player.

Example:
```lua
local scopes = exports.onesync_scopes
local players = scopes:GetPlayersInScope(player)

print(players)
-- returns: { "4", "5", "6", ..., "3158" }
-- or false if the given player doesn't have a scope yet
```

## `TriggerEventInPlayerScope`
This triggers an event to all players within the scope of the given player.

Example:
```lua
local scopes = exports.onesync_scopes
local eventPlayers = scopes:TriggerEventInPlayerScope("some-event-name:yes", player, arg1, arg2, arg3, ...)
-- tip: same syntax as TriggerClientEvent

print(eventPlayers)
-- returns a table of players that the event was sent to
-- or false if the given player doesn't have a scope yet
```

## `TriggerLatentEventInPlayerScope`
This triggers a ***latent*** event to all players within the scope of the given player, which is useful for events that carry a large (1KB+) payload.

Example:
```lua
local scopes = exports.onesync_scopes
local eventPlayers = scopes:TriggerLatentEventInPlayerScope("some-event-name:yes", player, 500, arg1, arg2, arg3, ...)
-- tip: same syntax as TriggerLatentClientEvent

print(eventPlayers)
-- returns a table of players that the event is sending to
-- or false if the given player doesn't have a scope yet
```