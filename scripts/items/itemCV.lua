local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_CV = Isaac.GetItemIdByName("Curriculum Vitae")

local CurriculumStats = {
	LUCK = 1
}

---FUNCIONA---
function mod:onPickupCV(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CV) then
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + CurriculumStats.LUCK * player:GetCollectibleNum(COLLECTIBLE_CV)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickupCV)


---NOFUNCIONA---
function mod:ConfussionTearEffectCV(player, TearFlags)
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(COLLECTIBLE_CV) then ---ATTEMPT TO CALL A NIL VALUE---
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			local roll = math.random(100)
			local MaxLuck = 6
			if roll <= ((100) - 15) * player.Luck / MaxLuck + 15 then
				player.TearFlags = player.TearFlags | player.TearFlags.ConfussionTearEffectCV
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.ConfussionTearEffectCV)


---POR AÑADIR: SONIDO DE WAJAJA CUANDO SE PILLE EL ITEM---