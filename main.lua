local mod = RegisterMod("Mara Mod", 1)

local COLLECTIBLE_CAFE = Isaac.GetItemIdByName("Café")
local CafeStats = {
	DAMAGE = 0.4,
	SHOTSPEED = 0.5,
	SPEED = 0.3
}
local COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")

function mod:onGameStart (fromSave)
	if not fromSave then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CAFE, Vector (320, 280), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CACAHUETILLO, Vector (320, 250), Vector.Zero, nil)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)

function mod:onPickup(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CAFE) then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then	
			player.Damage = player.Damage + CafeStats.DAMAGE * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + CafeStats.SPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + CafeStats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_WIGGLE
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickup)

mod.COLLECTIBLE = Isaac.GetItemIdByName("item")
local UseCount = 0

function mod:Activate_Item(_Type)
	local player = Isaac.GetPlayer(0)
	if player:GetMaxHearts() >= 4 then
		player:AddCoins (3)
		player:AddRottenHearts(1)
                UseCount = UseCount + 1
	end
	
	player:AnimateCollectible(mod.COLLECTIBLE, "UseItem", "PlayerPickup")
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.Activate_Item, mod.COLLECTIBLE)
