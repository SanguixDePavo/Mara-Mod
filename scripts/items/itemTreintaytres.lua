local mod = RegisterMod("Mara Mod", 1)
local COLLECTIBLE_33 = Isaac.GetItemIdByName("Treinta y tres")


local TreintaytresStats = {
    LUCK = 0.33,
    DAMAGE = 0.33,
    SHOTSPEED = 0.33,
    SPEED = 0.33,
    TEARS = 0.33,
    TEARHEIGHT = 10,
    TEARFALLINGSPEED = 0,
    RANGE = 13.20
}

local function tearsUp(firedelay, val)
    local currentTears = 30 / (firedelay + 1)
    local newTears = currentTears + val
    return math.max((30 / newTears) - 1, -0.99)
end


function mod:onPickUp33(player, cacheFlag)

    if player:HasCollectible(COLLECTIBLE_33) then

		if cacheFlag == CacheFlag.CACHE_LUCK then
		
			player.Luck = player.Luck + TreintaytresStats.LUCK * player:GetCollectibleNum(COLLECTIBLE_33)

        elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then

			player.ShotSpeed = player.ShotSpeed + TreintaytresStats.SHOTSPEED * player:GetCollectibleNum(COLLECTIBLE_33)
		
        elseif cacheFlag == CacheFlag.CACHE_DAMAGE then
            
            player.Damage = player.Damage + TreintaytresStats.DAMAGE * player:GetCollectibleNum(COLLECTIBLE_33)

        elseif cacheFlag == CacheFlag.CACHE_SPEED then

            player.MoveSpeed = player.MoveSpeed + TreintaytresStats.SPEED * player: GetCollectibleNum(COLLECTIBLE_33)

        elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then

            local newDelay = tearsUp(player.MaxFireDelay, TreintaytresStats.TEARS * player:GetCollectibleNum(COLLECTIBLE_33))
            player.MaxFireDelay = newDelay
        
        elseif cacheFlag == CacheFlag.CACHE_RANGE then
            
            player.TearHeight = player.TearHeight - TreintaytresStats.TEARHEIGHT * player: GetCollectibleNum(COLLECTIBLE_33)
            player.TearFallingSpeed = player.TearFallingSpeed + TreintaytresStats.TEARFALLINGSPEED * player: GetCollectibleNum(COLLECTIBLE_33)
            player.TearRange = player.TearRange + TreintaytresStats.RANGE * player: GetCollectibleNum(COLLECTIBLE_33)

        end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onPickUp33)


function mod:burnTearEffect33(entityTear)
	local player = Isaac.GetPlayer(0)

	if player:HasCollectible(COLLECTIBLE_33) and math.random(100) <= (85 * player.Luck / 6) + 15 then

		entityTear:AddTearFlags(TearFlags.TEAR_BURN)

		entityTear:ChangeVariant(TearVariant.FIRE_MIND)
    end 
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.burnTearEffect33)


---Por añadir: sonido de treinta y tres de TTS con lágrimas o al recoger el ítem---