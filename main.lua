local mod = RegisterMod("Mara Mod", 1)

local COLLECTIBLE_CAFE = Isaac.GetItemIdByName("Café")
local COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")
local TRINKET_VOZDERORO = Isaac.GetTrinketIdByName("Voz de Roro")
local TRINKET_TENEDOL = Isaac.GetTrinketIdByName("TENEDOL")
local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")


local CafeStats = {
	DAMAGE = 0.2,
	SHOTSPEED = 0.3,
	SPEED = 0.3
}

function mod:onGameStart (fromSave)
	if not fromSave then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CAFE, Vector (320, 280), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CACAHUETILLO, Vector (320, 250), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_VOZDERORO, Vector (320, 200), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_TENEDOL, Vector (320, 100), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_SENYORC, Vector (370, 100), Vector.Zero, nil)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)

function mod:onPickup1(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CAFE) then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then	
			player.Damage = player.Damage + CafeStats.DAMAGE * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + CafeStats.SPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + CafeStats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_WIGGLE
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickup1)

function mod:onPickup2(player, cacheFlag)
	local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
	if player:AddCollectible(COLLECTIBLE_SENYORC) then Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_REVERSE_LOVERS, nearby, Vector(0,0), nil)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, mod.onPickup2)



mod.COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")
local UseCount = 0

function mod:Activate_Item(_Type)
	local player = Isaac.GetPlayer(0)
	if player:GetMaxHearts() >= 4 then
		player:AddCoins(3)
		player:AddRottenHearts(1)
                UseCount = UseCount + 1
	end
	
	player:AnimateCollectible(mod.COLLECTIBLE_CACAHUETILLO, "UseItem", "PlayerPickup")
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.Activate_Item, mod.COLLECTIBLE_CACAHUETILLO)

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

