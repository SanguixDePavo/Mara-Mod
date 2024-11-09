local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE = Isaac.GetItemIdByName("Ritmo de la guerra")

local stats = {
	SHOTSPEED = 0.25
}


function mod:onPickup(player, cacheFlag)

	if player:HasCollectible(COLLECTIBLE) and cacheFlag == CacheFlag.CACHE_SHOTSPEED then

		player.ShotSpeed = player.ShotSpeed + stats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE)

	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickup)

