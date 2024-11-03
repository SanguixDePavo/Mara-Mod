local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo") ---Por si es necesario en el futuro---

---FUNCIONA---
function mod:CacahuetilloActivate_Item(_Type)
	local player = Isaac.GetPlayer(0)
	local UseCount = 0
	if player:GetMaxHearts() >= 4 then
		player:AddCoins(3)
		player:AddRottenHearts(1)
                UseCount = UseCount + 1
	end
	player:AnimateCollectible(mod.COLLECTIBLE_CACAHUETILLO, "UseItem", "PlayerPickup")
end

mod.COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.CacahuetilloActivate_Item, mod.COLLECTIBLE_CACAHUETILLO)

---Función: con 2 contenedores de vida roja otorga +3 coins y convierte 1 corazón rojo en rottenheart; si tienes el corazón vacío, te lo recupera---
---Si no tienes 2 contenedores de vida roja no hace nada---