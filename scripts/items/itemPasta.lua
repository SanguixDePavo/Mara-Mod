local mod = RegisterMod("Mara Mod", 1)


--funciona
function mod:pastaActive(_type)--Cura 1 corazón si tienes como mínimo 1 contenedor vacío de vida roja
    local player = Isaac.GetPlayer(0)
  

    if player:GetMaxHearts() >= 2 then
		
		player:AddHearts(4)

    end
    
    player:AnimateCollectible(mod.COLLECTIBLE_PASTA, "UseItem", "PlayerPickup")

end

mod.COLLECTIBLE_PASTA = Isaac.GetItemIdByName("Pasta")

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.pastaActive, mod.COLLECTIBLE_PASTA)


mod.isPastaActive = false --Para las siguientes funciones 


function mod:onEnterRoom() --Resetear el efecto para que no persista entre salas
    
    mod.isPastaActive = false
end


function mod:onUsePastaItem(_, player) --En sala actual
    
    mod.isPastaActive = true

end


function mod:onTearUpdate(tear)---Chance de veneno
    
    local player = Isaac.GetPlayer(0)
    
    if player:HasCollectible(mod.COLLECTIBLE_PASTA) and mod.isPastaActive then
        
        local poisonChance = 0.08

        
        if math.random() < poisonChance then
            
            tear.TearFlags = tear.TearFlags | TearFlags.TEAR_POISON
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.onTearUpdate)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onEnterRoom)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onUsePastaItem, mod.COLLECTIBLE_PASTA)