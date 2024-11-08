local mod = RegisterMod("Mara Mod", 1)

local game = Game()

local COLLECTIBLE_PAPEL = Isaac.GetItemIdByName("Papel cagao")



---ESTADÍSTICAS DEL POISON---
local PAPEL_POISON_CHANCE = 0.6
local PAPEL_POISON_LENGTH = 3
local ONE_INTERVAL_OF_POISON = 20


---FUNCIONA---
function mod:papelCagaoNewRoom()
    local playerCount = game:GetNumPlayers()


    for playerIndex = 0, playerCount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local copyCount = player:GetCollectibleNum(COLLECTIBLE_PAPEL)


        if copyCount > 0 then
            local rng = player:GetCollectibleRNG(COLLECTIBLE_PAPEL)
            local entities = Isaac.GetRoomEntities()


            for _, entity in ipairs(entities) do
              
                if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
                   
                    if rng:RandomFloat() < PAPEL_POISON_CHANCE then
                      
                        entity:AddPoison(
                            EntityRef(player),
                            PAPEL_POISON_LENGTH + (ONE_INTERVAL_OF_POISON * copyCount),
                            player.Damage
                        )
                    end
                end
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.papelCagaoNewRoom)

---Función: al entrar en una sala nueva, cada entidad tiene un 60% de probabilidades de sufrir poison y hace entre 1 y 2 ticks del daño del jugador---