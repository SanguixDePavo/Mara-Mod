local mod = RegisterMod("Mara Mod", 1)

---FUNCIONA---
function mod:cacahuetilloActivate_Item(_Type)
	local player = Isaac.GetPlayer(0)
	local UseCount = 0
	
	if player:GetMaxHearts() >= 2 then
		
		player:AddCoins(3)
		
		player:AddRottenHearts(1)
       
			UseCount = UseCount + 1
	end
	
	player:AnimateCollectible(mod.COLLECTIBLE_CACAHUETILLO, "UseItem", "PlayerPickup")
end

mod.COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.cacahuetilloActivate_Item, mod.COLLECTIBLE_CACAHUETILLO)

---Función: con 1 contenedores de vida roja otorga +3 coins y convierte 1 corazón rojo en rottenheart; si tienes el corazón vacío, te lo recupera---
---Si no tienes 1 contenedores de vida roja no hace nada---