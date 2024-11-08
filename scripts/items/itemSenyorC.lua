local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")

local hasSpawnedCard = false

function mod:onPlayerUpdate(player) --Proporciona The lovers?

    if player:HasCollectible(COLLECTIBLE_SENYORC) and not hasSpawnedCard then
        local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
        
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_REVERSE_LOVERS, nearby, Vector(0,0), player)
        
        hasSpawnedCard = true
    end
end

function mod:onGameStart(isContinued) --Se resetea para la siguiete run
    if not isContinued then
        hasSpawnedCard = false
    end
end


mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPlayerUpdate)
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)


local curseApplied = false

local function onItemPickup(pickup) --Se aplica curse of the unknown
    local player = Isaac.GetPlayer(0)  

  
    if player:HasCollectible(COLLECTIBLE_SENYORC) then
        
        local level = Game():GetLevel()

       
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, false)

        curseApplied = true
    end
end


mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, onItemPickup)


local function onNewRoom() --Se sigue aplicando en el resto del piso

    curseApplied = false
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, onNewRoom)



local SenyorCStats = {
    DAMAGE = 1.22
}

function mod:onPickUpSenyorC(player, cacheFlag) --Aumenta la estadística de damage

    if player:HasCollectible(COLLECTIBLE_SENYORC) then
       
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            
            player.Damage = player.Damage + SenyorCStats.DAMAGE * player:GetCollectibleNum(COLLECTIBLE_SENYORC)
        
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickUpSenyorC)