--------------------------------
-- General Functions File     --
-- Use Encoding: Windows 1252 --
--------------------------------

sw.loadAdmins()
sw.loadAdverts()
sw.loadClasses()

---@param id number
function sw.join(id)
    sw.players[id] = sw.Player:new(id)
end

---@param id number
---@param reason number
function sw.leave(id, reason)
    sw.players[id]:destructor()
    sw.players[id] = nil
end

---@param id number
function sw.attack(id)
    local playerWeaponType = player(id, "weapontype")

    if ((playerWeaponType > 0) and (playerWeaponType < 50)) then
        -- Create Laser
        local laser = sw.Laser:new()
        table.insert(sw.lasers, laser)

        laser:initialize(id)
    end
end

function sw.always()
    local removeLasers = {}
    local pls = player(0, "tableliving")

    -- Step of lasers
    for i, laser in pairs(sw.lasers) do
        local laserX, laserY = laser:getPosition()
        if (laser:checkTileCollision() or laser:checkLiveTime()) then
            table.insert(removeLasers, i)
        else
            for _, p in pairs(pls) do
                if (p ~= laser:getPerformer()) then
                    -- Hit the player (check collision)
                    if (Distance(laserX, laserY, player(p, "x"), player(p, "y")) <= 14) then
                        sw.players[p]:hit(laser)
                        table.insert(removeLasers, i)
                        break
                    end
                end
            end

            laser:laserMove()
        end
    end

    -- Remove lasers from [removeLasers] array
    for _, laser in pairs(removeLasers) do
        sw.lasers[laser]:destructor()
        table.remove(sw.lasers, laser)
    end
end

---@param id number
---@param button number
function sw.serveraction(id, button)
    if (button == 1) then
        
    elseif (button == 2) then
        sw.menuHeroes(id, 0)
    end
end

---@param id number
function sw.spawn(id)
    sw.players[id]:spawn()
end

---@param id number
---@param source number
---@param weapon number
---@param hpdmg number
---@return number
function sw.hit(id, source, weapon, hpdmg)
    return 1
end

---@param id number
---@param title string
---@param button number
function sw.menu(id, title, button)
    if (string.sub(title, 1, 17) == "Choose Your Class") then
        sw.renderMenuClasses(id, button)
    end
end

---@param id number
---@param team number
function sw.team(id, team)
    if (team == 1) then
        sw.players[id]:setAffiliation("Empire")
    elseif (team == 2) then
        sw.players[id]:setAffiliation("Republic")
    end
end

function sw.die(id)
    sw.players[id]:die()
end