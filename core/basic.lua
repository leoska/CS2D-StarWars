--------------------------------
-- General Functions File     --
-- Use Encoding: Windows 1252 --
--------------------------------

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