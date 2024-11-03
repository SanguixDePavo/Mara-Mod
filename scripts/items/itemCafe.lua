local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_CAFE = Isaac.GetItemIdByName("Café")

local CafeStats = {
	SHOTSPEED = 0.5,
	SPEED = 0.3
}

---FUNCIONA---
function mod:onPickupCafe(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CAFE) then
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + CafeStats.SPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + CafeStats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_WIGGLE
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickupCafe)

---Función: + MS, +Shotspeed, wiggle tear effect---