local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")

---FUNCIONA UNA VEZ POR SESION DE JUEGO---
function mod:onPickupSenyorC()
	local player = Isaac.GetPlayer(0)
	local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
	if player:HasCollectible(COLLECTIBLE_SENYORC) == true then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 62, nearby, Vector(0,0), player)
		mod:RemoveCallback (ModCallbacks.MC_POST_UPDATE, mod.onPickupSenyorC)
		end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onPickupSenyorC, EntityType.ENTITY_PLAYER)


---Función: (1) dropear The Lovers?; (2) chance de dropear hearts; (3) plantearium chance; (4) curse of the Unknown permanente (vida invisible)---
---funciones por añadir: más drop de corazones rojos, planetarium chance 5%, curse of the unknown

