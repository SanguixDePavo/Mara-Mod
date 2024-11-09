local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE = Isaac.GetItemIdByName("Juramentada")

local stats = {
	SPEED = 0.15
}


function mod:onPickup(player, cacheFlag)

	if player:HasCollectible(COLLECTIBLE) and cacheFlag == CacheFlag.CACHE_SPEED then

		player.MoveSpeed = player.MoveSpeed + stats.SPEED * player:GetCollectibleNum(COLLECTIBLE)

	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickup)

