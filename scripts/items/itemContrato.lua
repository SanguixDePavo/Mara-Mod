local mod = RegisterMod("Mara Mod", 1)
local game = Game()
local COLLECTIBLE_CONTRATO = Isaac.GetItemIdByName("Contrato")

local CONTRATO_FEAR_CHANCE = 1
local CONTRATO_FEAR_LENGTH = 60

---FUNCIONA---
function mod:contratoFearNewRoom()
	local playerCount = game:GetNumPlayers()

	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		local copyCount = player:GetCollectibleNum(COLLECTIBLE_CONTRATO)

		if copyCount > 0 then
			local rng = player:GetCollectibleRNG(COLLECTIBLE_CONTRATO)
			local entities = Isaac.GetRoomEntities()
			
			for _, entity in ipairs(entities) do
				
				if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
					
					if rng:RandomFloat() < CONTRATO_FEAR_CHANCE then
						
						entity:AddFear(EntityRef(player), CONTRATO_FEAR_LENGTH)

					end
				end
			end 
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.contratoFearNewRoom)

---Función: en cada sala nueva que entres, inflinge fear a todos los enemigos durante 2 segundos (60 frames)---