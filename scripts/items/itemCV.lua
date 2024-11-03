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
function mod:confussionTearEffectCV(entityTear)
	local player = Isaac.GetPlayer(0)

	if player:HasCollectible(COLLECTIBLE_CV) and math.random(100) <= (85 * player.Luck / 6) + 15 then

		entityTear:AddTearFlags(TearFlags.TEAR_CONFUSION)

		entityTear:ChangeVariant(TearVariant.METALLIC)

	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.confussionTearEffectCV)

---POR AÑADIR: SONIDO DE WAJAJA CUANDO SE PILLE EL ITEM---