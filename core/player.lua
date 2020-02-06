--------------------------------
-- Player Class File          --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
sw.Player = {}

---@class sw.Player
function sw.Player:new(id)
    local private = {}
        -- Private properties and methods
        private.id      = id;
        private.health  = 0;
        private.speed   = 0;
        private.class   = 0;
        
    local public = {}
        -- Public properties and methods

        ---@destructor
        function public.destructor()
        end

        ---@getter
        ---@return number
        function public.getHealth()
            return private.health
        end

    setmetatable(public, self)
    self.__index = self; return public
end