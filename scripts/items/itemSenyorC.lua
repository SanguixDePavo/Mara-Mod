local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")

local hasSpawnedCard = false

function mod:onPlayerUpdate(player)

    if player:HasCollectible(COLLECTIBLE_SENYORC) and not hasSpawnedCard then
        local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
        
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_LOVERS, nearby, Vector(0,0), player)
        
        hasSpawnedCard = true
    end
end

-- Reiniciamos el flag cuando comience una nueva partida
function mod:onGameStart(isContinued)
    if not isContinued then
        hasSpawnedCard = false
    end
end

-- Añadimos los callbacks
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPlayerUpdate)
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)


---Función: (1) dropear The Lovers?; (2) chance de dropear hearts; (3) plantearium chance; (4) curse of the Unknown permanente (vida invisible)---
---funciones por añadir: más drop de corazones rojos, planetarium chance 5%, curse of the unknown

