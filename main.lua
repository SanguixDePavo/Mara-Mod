local mod = RegisterMod("Mara Mod", 1)
local game = Game()

---LOCAL DE ITEMS---
local COLLECTIBLE_CAFE = Isaac.GetItemIdByName("Café")
local COLLECTIBLE_CACAHUETILLO = Isaac.GetItemIdByName("Cacahuetillo")
local TRINKET_VOZDERORO = Isaac.GetTrinketIdByName("Voz de Roro")
local TRINKET_TENEDOL = Isaac.GetTrinketIdByName("TENEDOL")
local COLLECTIBLE_SENYORC = Isaac.GetItemIdByName("Señor C")
local COLLECTIBLE_CV = Isaac.GetItemIdByName("Curriculum Vitae")
local COLLECTIBLE_CONTRATO = Isaac.GetItemIdByName("Contrato")

---STATS DE ITEMS---
local CafeStats = {
	SHOTSPEED = 0.5,
	SPEED = 0.3
}

local CurriculumStats = {
	LUCK = 1
}

local CONTRATO_FEAR_CHANCE = 1
local CONTRATO_FEAR_LENGTH = 60

---START---
function mod:onGameStart (fromSave)
	if not fromSave then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_CV, Vector (320, 220), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_VOZDERORO, Vector (320, 200), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_TRINKET, TRINKET_TENEDOL, Vector (320, 100), Vector.Zero, nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant. PICKUP_COLLECTIBLE, COLLECTIBLE_SENYORC, Vector (370, 100), Vector.Zero, nil)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)


---FUNCIONAL---
function mod:onPickupCafe(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CAFE) then
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + CafeStats.SPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + CafeStats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE_CAFE)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_WIGGLE
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickupCafe)

---FUNCIONAL---
function mod:onPickupCV(player, cacheFlag)
	if player:HasCollectible(COLLECTIBLE_CV) then
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + CurriculumStats.LUCK * player:GetCollectibleNum(COLLECTIBLE_CV)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickupCV)


---NOFUNCIONA---
function mod:ConfussionTearEffectCV(player, TearFlags)
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(COLLECTIBLE_CV) then ---ATTEMPT TO CALL A NIL VALUE---
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			local roll = math.random(100)
			local MaxLuck = 6
			if roll <= ((100) - 15) * player.Luck / MaxLuck + 15 then
				player.TearFlags = player.TearFlags | player.TearFlags.TEAR_CONFUSION
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.ConfussionTearEffectCV)

---FUNCIONA UNA VEZ POR SESION DE JUEGO---
function mod:onPickupSenyorC()
	local player = Isaac.GetPlayer(0)
	local nearby = Isaac.GetFreeNearPosition(player.Position, 10)
	if player:HasCollectible(COLLECTIBLE_SENYORC) == true then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 62, nearby, Vector(0,0), player)
		mod:RemoveCallback (ModCallbacks.MC_POST_UPDATE, mod.onPickupSenyorC)
		end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onPickupSenyorC, EntityType.ENTITY_PLAYER)

---FUNCIONAL---
function mod:ContratoFearNewRoom()
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

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ContratoFearNewRoom)


---FUNCIONAL---
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

