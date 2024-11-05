local mod = RegisterMod("Mara Mod", 1)
local TRINKET_VOZDERORO = Isaac.GetTrinketIdByName("Voz de Roro")

local hasSpawnedCard = false


---NOFUNCIONA---
function mod:GetTrinketVozderoro(TRINKET_VOZDERORO)
	local player = Isaac.GetPlayer(0)
	local nearby = Isaac.GetFreeNearPosition(player.Position, 10)


	if player:HasTrinket(TRINKET_VOZDERORO) then
		
		if player:GetTotalDamageTaken() ==6 and not hasSpawnedCard then
        
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_CREDIT, nearby, Vector(0,0), player)
        
        hasSpawnedCard = true
		
		end
	end
end

---NEW GAME---
function mod:onGameStart(isContinued)
    if not isContinued then
        hasSpawnedCard = false
    end
end

---CALLBACKS---
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)
mod:AddCallback(ModCallbacks.MC_GET_TRINKET, mod.GetTrinketVozderoro)

---función del trinket: al recibir 6 de daño = 3 corazones, se destruye y suelta una Credit Card---
---la segunda opción, demasiado compleja, es que cada hit reste -1 a los ítems de la tienda y destruya al comprar uno---
---como tercera opción, es dejar la primera función a otro trinket ("chantaje emocional/pasiva de mujer"); en este subir la probabilidad de charm, como el trinket de poison chance)---



--player:TryRemoveTrinket(TRINKET_VOZDERORO)