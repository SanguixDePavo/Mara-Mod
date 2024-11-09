local mod = RegisterMod("Mara Mod", 1)
local game = Game()

--Seguramente hay que añadir mas campos--
local knightRadiant = {
    name = "Caballero radiante",
    items = {
        {
            name = "Ritmo de la guerra",
            obtained = false
        },
        {
            name = "Palabras radiantes",
            obtained = false
        },
        {
            name = "Camino de los reyes",
            obtained = false
        },
        {
            name = "Juramentada",
            obtained = false
        }
    },
    stats = {
        DAMAGE = 6,
        SPEED = 0.3,
        SHOTSPEED = 0.5,
        RANGE = 10,
        LUCK = -2,
        SOULHEARTS = 8,
        FLY = true,
        WEAPON = WeaponType.WEAPON_SPIRIT_SWORD
    },
    skin = "",
    sound = ""    
}
local isTransformed = false
local itemAmount = 0
local decreaseStats = false
local changeWeapon = false

local function evaluateStats(player)
    player:AddCacheFlags(CacheFlag.CACHE_FLYING)
   	player:AddCacheFlags(CacheFlag.CACHE_WEAPON)
   	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
   	player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
   	player:AddCacheFlags(CacheFlag.CACHE_RANGE)
   	player:AddCacheFlags(CacheFlag.CACHE_SPEED)
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
    if not decreaseStats then
        player:AddSoulHearts(knightRadiant.stats.SOULHEARTS)
    end
    player:EvaluateItems()
end

local function evaluateTransformation(player)

    for i = 1, #knightRadiant.items do
        if player:HasCollectible(Isaac.GetItemIdByName(knightRadiant.items[i].name), true) and not knightRadiant.items[i].obtained then
		    itemAmount = itemAmount + 1
            knightRadiant.items[i].obtained = true
            print(itemAmount)
        end
	end

    if itemAmount >= 3 and not isTransformed then
        game:GetHUD():ShowItemText("Las palabras son aceptadas")
        isTransformed = true
        changeWeapon = true
        --Añadir sprite de la transformacion xdd--
    	evaluateStats(player)
    elseif isTransformed and itemAmount < 3 then
        isTransformed = false
        decreaseStats = true
    	evaluateStats(player)
        changeWeapon = true
        decreaseStats = false
    end

end

--Se evalua cuando se inicia la partida--
function mod:onGameStart(isContinued) 
    if isContinued then
        print("continue")
        evaluateTransformation(game:GetPlayer(0))
    else
        print("not continue")
        for i = 1, #knightRadiant.items do
            knightRadiant.items[i].obtained = false
        end
        itemAmount = 0
    end

end


mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)

function mod:evaluateTransformation(player) 

    evaluateTransformation(player)

end

--Se evalua cada frame yow--
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.evaluateTransformation)

--Efectos de la transformacion--
function mod:onTransform(player, cacheFlag)
    self:handleFlying(player, cacheFlag)
    self:handleWeapon(player, cacheFlag)
    self:handleDamage(player, cacheFlag)
    self:handleShotSpeed(player, cacheFlag)
    self:handleSpeed(player, cacheFlag)
    self:handleRange(player, cacheFlag)
    self:handleLuck(player, cacheFlag)
end

function mod:handleFlying(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FLYING then
        if isTransformed then
            player.CanFly = true
        elseif decreaseStats then
            player.CanFly = false
        end
    end
end

function mod:handleWeapon(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_WEAPON then
        if isTransformed and not player:HasWeaponType(knightRadiant.stats.WEAPON) and changeWeapon then
            player:AddCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
        elseif decreaseStats then
            player:RemoveCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
        end
        changeWeapon = false
    end
end

function mod:handleDamage(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        if isTransformed then
            player.Damage = player.Damage + knightRadiant.stats.DAMAGE
        elseif decreaseStats then
            player.Damage = player.Damage - knightRadiant.stats.DAMAGE
        end
    end
end

function mod:handleShotSpeed(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
        if isTransformed then
            player.ShotSpeed = player.ShotSpeed + knightRadiant.stats.SHOTSPEED
        elseif decreaseStats then
            player.ShotSpeed = player.ShotSpeed - knightRadiant.stats.SHOTSPEED
        end
    end
end

function mod:handleSpeed(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_SPEED then
        if isTransformed then
            player.MoveSpeed = player.MoveSpeed + knightRadiant.stats.SPEED
        elseif decreaseStats then
            player.MoveSpeed = player.MoveSpeed - knightRadiant.stats.SPEED
        end
    end
end

function mod:handleRange(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_RANGE then
        if isTransformed then
            player.TearRange = player.TearRange + knightRadiant.stats.RANGE
        elseif decreaseStats then
            player.TearRange = player.TearRange - knightRadiant.stats.RANGE
        end
    end
end

function mod:handleLuck(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_LUCK then
        if isTransformed then
            player.Luck = player.Luck + knightRadiant.stats.LUCK
        elseif decreaseStats then
            player.Luck = player.Luck - knightRadiant.stats.LUCK
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onTransform)