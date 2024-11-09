local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE = Isaac.GetItemIdByName("Palabras radiantes")

local stats = {
	DAMAGE = 0.3
}


function mod:onPickup(player, cacheFlag)

	if player:HasCollectible(COLLECTIBLE) and cacheFlag == CacheFlag.CACHE_DAMAGE then

		player.Damage = player.Damage + stats.DAMAGE * player:GetCollectibleNum(COLLECTIBLE)

	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickup)

