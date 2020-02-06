--------------------------------
-- Player Class File          --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
sw.Player = {}

-- Class body
function sw.Player:new(id, health)
    local private = {}
        -- Private properties and methods
        private.id      = id;
        private.health  = health;
        private.speed   = 0;
        private.class   = 0;
        
    local public = {}
        -- Public properties and methods
        function public.getHealth()
            return private.health
        end

    setmetatable(public, self)
    self.__index = self; return public
end