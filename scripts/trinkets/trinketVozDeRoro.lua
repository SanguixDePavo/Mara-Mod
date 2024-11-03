local mod = RegisterMod("Mara Mod", 1)
local TRINKET_VOZDERORO = Isaac.GetTrinketIdByName("Voz de Roro")

---NOFUNCIONA---
function mod:GetTrinketVozderoro(TRINKET_VOZDERORO)
	local player = Isaac.GetPlayer(0)
	if player:HasTrinket(TRINKET_VOZDERORO) then
		if player:GetTotalDamageTaken() ==6 then
			player:AddCard(43)
		elseif player:GetTotalDamageTaken() ==6 then
			player:TryRemoveTrinket(TRINKET_VOZDERORO)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_GET_TRINKET, mod.GetTrinketVozderoro)

---función del trinket: al recibir 6 de daño = 3 corazones, se destruye y suelta una Credit Card---
---la segunda opción, demasiado compleja, es que cada hit reste -1 a los ítems de la tienda y destruya al comprar uno---
---como tercera opción, es dejar la primera función a otro trinket ("chantaje emocional/pasiva de mujer"); en este subir la probabilidad de charm, como el trinket de poison chance)---
