local mod = RegisterMod("Mara Mod", 1)

---LOCALS DE COLLECTIBLES Y TRINKETS---

local COLLECTIBLE_CAFE = Isaac.GetItemIdByName("Café")

local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")

local COLLECTIBLE_CV = Isaac.GetItemIdByName("Curriculum Vitae")

local COLLECTIBLE_CONTRATO = Isaac.GetItemIdByName("Contrato")

local COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")

local COLLECTIBLE_PASTA = Isaac.GetItemIdByName("Pasta")

local COLLECTIBLE_MEDICAMENTO = Isaac.GetItemIdByName("Medicamento")

local COLLECTIBLE_BEBIDA = Isaac.GetItemIdByName("Energética")

local COLLECTIBLE_33 = Isaac.GetItemIdByName("Treinta y tres")

local COLLECTIBLE_PAPEL = Isaac.GetItemIdByName("Papel cagao")

local TRINKET_VOZDERORO = Isaac.GetTrinketIdByName("Voz de Roro")

local TRINKET_TENEDOL = Isaac.GetTrinketIdByName("TENEDOL")

local TRINKET_OH = Isaac.GetItemIdByName("Oh")


local COLLECTIBLE_CAMINO = Isaac.GetItemIdByName("Camino de los reyes")

local COLLECTIBLE_PALABRAS = Isaac.GetItemIdByName("Palabras radiantes")

local COLLECTIBLE_JURAMENTADA = Isaac.GetItemIdByName("Juramentada")

local COLLECTIBLE_RITMO = Isaac.GetItemIdByName("Ritmo de la guerra")


---START---

function mod:onGameStart (fromSave)
	if not fromSave then 

		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CAMINO, Vector (320, 220), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_PALABRAS, Vector (320, 220), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_JURAMENTADA, Vector (320, 220), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_RITMO, Vector (320, 220), Vector.Zero, nil)

		--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_OH, Vector (320, 200), Vector.Zero, nil)
		
		--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_TENEDOL, Vector (320, 100), Vector.Zero, nil)

	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)


