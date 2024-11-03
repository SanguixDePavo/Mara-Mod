local mod = RegisterMod("Mara Mod", 1)
local TRINKET_TENEDOL = Isaac.GetTrinketIdByName("TENEDOL")

---NOFUNCIONA---
function mod:GetTrinketTenedol(TRINKET_TENEDOL)
	local player = Isaac.GetPlayer(0)
	local rng = player:GetTrinketRNG(TRINKET_TENEDOL)
	local roll = rng:RandomInt(100)
	local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
	local BuyShopItem = player:AddCollectible(ItemPoolType.POOL_SHOP)
	if player:HasTrinket(TRINKET_TENEDOL) then
		if BuyShopItem then  
				if roll < 20 and math.random() <0.3 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, nearby, Vector(0,0), nil) 
				elseif roll < 40 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 1, nearby, Vector(0,0), nil) 
				elseif roll < 60 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 1, nearby, Vector(0,0), nil) 
				elseif roll < 80 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 1, nearby, Vector(0,0), nil) 
				elseif roll < 100 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_CHEST, 1, nearby, Vector(0,0), nil) 
			end
			return true
		end
	end
end

mod:AddCallback(ModCallbacks.MC_GET_TRINKET, mod.GetTrinketTenedol, mod.GetTrinketRNG)


---función del trinket: al comprar un item en la tienda (collectible, no pickup), spawnear un pickup aleatoriamente, siendo el chest el de menor probabilidad y la coin el que más)---
